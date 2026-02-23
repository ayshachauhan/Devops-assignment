function App() {
  const environment = process.env.REACT_APP_ENVIRONMENT;

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h1>React Multi-Environment App</h1>
      <h2>Environment:</h2>
      <p style={{ color: "blue", fontWeight: "bold" }}>
        {environment || "No Environment Provided"}
      </p>
    </div>
  );
}

export default App;
