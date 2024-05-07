const http = require('http');
const port = process.env.PORT || 8000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  const msg = 'Task deployed!\n'
  res.end(msg);
});

server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});
