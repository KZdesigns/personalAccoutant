import "./App.css";
import axios from "axios";
import Transactions from "./components/Transactions";
import { useEffect, useState } from "react";
import Form from "./components/Form";

const API_URL = "http://localhost:3000/api/v1/transactions";

const getAPIData = () => {
  return axios.get(API_URL).then((response) => response.data);
};

function App() {
  const [transactions, setTransactions] = useState([]);
  const [csv, setFile] = useState("");

  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      if (mounted) {
        setTransactions(items);
      }
    });
    return () => {
      mounted = false;
    };
  }, [csv]);

  return (
    <div className="App">
      <Form setFile={setFile}></Form>
      <Transactions transactions={transactions} />
    </div>
  );
}

export default App;
