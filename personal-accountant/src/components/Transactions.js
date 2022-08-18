import React from "react";

const Transactions = (props) => {
  const onDeleteHandler = async (event) => {
    event.preventDefault();
    await fetch(
      `http://localhost:3000/api/v1/transactions/${event.target.value}`,
      {
        method: "DELETE",
      }
    );
    props.setFile("delete");
  };

  return (
    <div>
      <h1>This Transaction are from the API</h1>
      {props.transactions.map((txn) => {
        return (
          <div key={txn.id}>
            <span>{txn.date}</span>
            <span>{txn.amount}</span>
            <span>{txn.description}</span>
            <button onClick={onDeleteHandler} value={txn.id}>
              Delete
            </button>
          </div>
        );
      })}
    </div>
  );
};

export default Transactions;
