# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import asyncnet, asyncdispatch

type
  Client = tuple
    socket: AsyncSocket
    name: string
    connected: bool

var clients {.threadvar.}: seq[Client]

proc sendOthers(client: Client, line: String) {.async.} =
  for c in clients:
    if c != client and c.connected:
      await c.socket.send(line & "\c\L")

proc processClient(socket: AsyncSocket) {.async.} =
  await socket.send("Enter your name: ")
  var client: Client = (socket, await socket.recvLine(), true)
  clients.add(client)
  asyncCheck client.sendOthers("+++ " & client.name & " arrived +++")



proc serve() {.async.} = 
  clients = @[]
  var srv = newAsyncSocket()

when isMainModule:
  echo("Hello, World!")
