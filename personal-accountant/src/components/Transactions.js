import React from "react";

const Transactions = (props) => {
  return (
    <div>
      <h1>This Transaction are from the API</h1>
      {props.transactions.map((txn) => {
        return (
          <div key={txn.id}>
            <span>{txn.date}</span>
            <span>{txn.amount}</span>
            <span>{txn.description}</span>
          </div>
        );
      })}
    </div>
  );
};

export default Transactions;
