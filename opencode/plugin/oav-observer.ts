import type { Plugin } from "@opencode-ai/plugin"

const DEFAULT_URL = "http://127.0.0.1:47632"

function sessionID(input: any): string {
  return input?.sessionID || input?.session_id || input?.sessionId || input?.session?.id || ""
}

async function send(payload: Record<string, any>) {
  const url = process.env.OPENCODE_AGENT_VIEW_URL || DEFAULT_URL
  try {
    await fetch(`${url}/events`, {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        ...payload,
        pid: typeof process !== "undefined" ? process.pid : 0,
        timestamp: Date.now(),
      }),
    })
  } catch {
    // OAV is optional; never break opencode when the TUI collector is closed.
  }
}

export default (async ({ project, directory }) => {
  const projectName = project?.name || (project?.directory || directory || process.cwd()).split("/").filter(Boolean).pop() || "opencode"
  const projectDirectory = project?.directory || directory || process.cwd()
  const base = { sourceApp: projectName, project: projectName, directory: projectDirectory }
  return {
    "tool.execute.before": async (input: any) => {
      await send({ ...base, type: "tool.execute.before", sessionID: sessionID(input), tool: input?.tool, status: "running" })
    },
    "tool.execute.after": async (input: any) => {
      await send({ ...base, type: "tool.execute.after", sessionID: sessionID(input), tool: input?.tool, status: "idle" })
    },
    event: async (event: any) => {
      const sid = sessionID(event)
      if (!sid) return
      await send({ ...base, type: event?.type || "event", sessionID: sid, status: "running" })
    },
    stop: async (input: any) => {
      await send({ ...base, type: "stop", sessionID: sessionID(input), status: "idle" })
    },
    "permission.ask": async (input: any) => {
      await send({ ...base, type: "permission.ask", sessionID: sessionID(input), status: "needs_input" })
    },
  }
}) satisfies Plugin
