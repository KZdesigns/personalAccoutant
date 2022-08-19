import React from "react";
import TxnItem from "./TxnItem";
import classes from "./Transaction.module.css";

const Transactions = (props) => {
  return (
    <React.Fragment>
      <h1>Transactions List</h1>
      <div className={classes.txnList}>
        {props.transactions.map((txn) => (
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
          />
        ))}
      </div>
    </React.Fragment>
  );
};

export default Transactions;
