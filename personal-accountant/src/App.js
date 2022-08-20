import "./App.css";
import Transactions from "./components/Transactions";
import { useEffect, useState } from "react";
import Form from "./components/Form";

const getTransactionData = async () => {
  const response = await fetch("http://localhost:3000/api/v1/transactions");
  const data = await response.json();
  return data;
};

const getGl_accounts = async () => {
  const response = await fetch("http://localhost:3000/api/v1/gl_accounts");
  const data = await response.json();
  return data;
};

const EXPORT_URL = "http://localhost:3000/api/v1/transactions/export.csv";

function App() {
  const [transactions, setTransactions] = useState([]);
  const [csv, setFile] = useState("");
  const [gl_accounts, setGl_acounts] = useState([]);

  useEffect(() => {
    let mounted = true;
    getTransactionData().then((items) => {
      if (mounted) {
        setTransactions(items);
      }
    });
    getGl_accounts().then((items) => {
      if (mounted) {
        setGl_acounts(items);
      }
    });
    return () => {
      mounted = false;
    };
  }, [csv]);

  return (
    <div className="App">
      <h1>Import Spreadsheet:</h1>
      <div className="nav">
        <Form setFile={setFile}></Form>
        <a href={EXPORT_URL}>export</a>
      </div>
      <Transactions
        transactions={transactions}
        gl_accounts={gl_accounts}
        setFile={setFile}
      />
    </div>
  );
}

export default App;
