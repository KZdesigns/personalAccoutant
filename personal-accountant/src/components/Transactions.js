import React, { useState } from "react";
import TxnItem from "./TxnItem";
import classes from "./Transaction.module.css";

const Transactions = (props) => {
  const [showFilter, setShowFilter] = useState(true);
  const NOTES = ["Need to request", "Requested", "Paid"];

  const filterTxns = props.transactions.filter((txn) => {
    return NOTES.includes(txn.notes);
  });

  const onFilterHandler = () => {
    setShowFilter((preState) => !preState);
  };

  return (
    <React.Fragment>
      <h1>Transactions List</h1>
      <button onClick={onFilterHandler}>Filter Transactions</button>
      <div className={classes.txnList}>
        {showFilter &&
          props.transactions.map((txn) => (
            <TxnItem
              key={txn.id}
              id={txn.id}
              date={txn.date}
              amount={txn.amount}
              description={txn.description}
              notes={txn.notes}
              gl_account_id={txn.gl_account_id}
              setFile={props.setFile}
              gl_accounts={props.gl_accounts}
              setTransactions={props.setTransactions}
            />
          ))}
        {!showFilter &&
          filterTxns.map((txn) => (
            <TxnItem
              key={txn.id}
              id={txn.id}
              date={txn.date}
              amount={txn.amount}
              description={txn.description}
              notes={txn.notes}
              gl_account_id={txn.gl_account_id}
              setFile={props.setFile}
              gl_accounts={props.gl_accounts}
              setTransactions={props.setTransactions}
            />
          ))}
      </div>
    </React.Fragment>
  );
};

export default Transactions;
