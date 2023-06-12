job "ns2server" {
  group "ns2server-group" {

    network {
      port "game" { static = 27015 }
      port "rcon" { static = 27016 }
      port "http" { to = 8080 }
    }

    task "ns2server-01" {
      driver = "docker"

      config {
        image = "gameservermanagers/linuxgsm-docker"
        labels {
          group = "ns2server-group"
        }
        volumes = [
          "/home/ns2server/serverfiles:/home/linuxgsm/serverfiles",
          "/home/ns2server/log:/home/linuxgsm/log",
          "/home/ns2server/lgsm/config-lgsm:/home/linuxgsm/lgsm/config-lgsm",
        ]
        ports = [
          "game",
          "rcon",
          "http"
        ]
      }

      env {
        GAMESERVER = "ns2server"
        LGSM_GITHUBUSER = "GameServerManagers"
        LGSM_GITHUBREPO = "LinuxGSM"
        LGSM_GITHUBBRANCH = "master"
      }

    }
  }
}
