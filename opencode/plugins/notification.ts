type PluginContext = {
  project: unknown
  client: unknown
  $: any
  directory: string
  worktree: string
}

type EventPayload = {
  event: {
    type: string
  }
}

export const NotificationPlugin = async ({ project, client, $, directory, worktree }: PluginContext) => {
  const sendNotification = async (msg: string): Promise<void> => {
    if (process.env.TMUX) {
      const sessionResult = await $`tmux display -p '#{session_name}'`
      const session = String(sessionResult.stdout).trim()
      if (!session) return

      const clientsResult = await $`tmux list-clients -t ${session} -F '#{client_tty}'`
      const tty = String(clientsResult.stdout)
        .split("\n")
        .find((line) => line.trim().length > 0)

      if (tty) {
        await $`printf "\e]9;${msg}\a" >${tty}`
      }
    } else {
      await $`printf "\e]9;${msg}\a"`
    }
  }

  return {
    event: async ({ event }: EventPayload) => {
      if (event.type === "session.idle") {
        const msg = "OpenCode Responded!"
        await sendNotification(msg)
      } else if (event.type === "permission.asked") {
        const msg = "OpenCode Asking for Permission!"
        await sendNotification(msg)
      }
    },
  }
}
