const http = require("http");

const PORT = process.env.PORT || ${{ values.port }};

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify({ status: "ok", service: "${{ values.appName }}" }));
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
