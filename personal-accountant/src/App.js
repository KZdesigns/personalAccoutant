import "./App.css";
import axios from "axios";
import Transactions from "./components/Transactions";
import { useEffect, useState } from "react";

const API_URL = "http://localhost:3000/api/v1/transactions";

const getAPIData = () => {
  return axios.get(API_URL).then((response) => response.data);
};

function App() {
  const [transactions, setTransactions] = useState([]);

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
  }, []);

  return (
    <div className="App">
      <h1>Hello!</h1>
      <Transactions transactions={transactions} />
    </div>
  );
}

export default App;
