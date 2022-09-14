## ABER CHAT

AberChat is a chat application that allows users to communicate with each other in real time. This
application is use socket.io to communicate between the server and the client. The server is written
in Node.js and the client is written in React.js. The server is deployed on Heroku and the client is
deployed on Netlify.

## Installation

flutter pub add aber_chat

## Usage

```dart
RoomPage(
  aberchatConfig: AberchatConfig(
    appId: '631ae2ed3a4f071fd104365a',
    apiKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmFiMGNkYWItMDA3My00ZDY0LTg4OTItYjNlODg4YWMyYTJkIiwiaWF0IjoxNjYyNzA2NDEzLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0In0.0lBM1iZkfcdC5yXL3y5qnFYpwKvtT20-s0W2WsBe02w',
    roomId: 'demo-aberchat',
  ),
  onReceivedEvent: (event) {
    print(event);
  },
)
```

## Features and bugs
we will still working to watch that

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Author
[Abersoft Technologies](https://abersoft.se)