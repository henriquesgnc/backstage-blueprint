exports.handler = async (event) => {
  console.log("Event:", JSON.stringify(event));

  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      message: "Hello from ${{ values.functionName }}",
      timestamp: new Date().toISOString(),
    }),
  };
};
