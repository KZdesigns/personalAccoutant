import React, { useState } from "react";
import classes from "./TxnItem.module.css";
import { getTransactionData } from "../App";

const TxnItem = (props) => {
  const [txn, setTxn] = useState({
    id: props.id,
    date: props.date,
    amount: props.amount,
    description: props.description,
    notes: props.notes,
    gl_account_id: props.gl_account_id,
  });

  const onUpdateDate = (event) => {
    setTxn((prevState) => {
      return { ...prevState, date: event.target.value };
    });
  };
  const onUpdateAmout = (event) => {
    setTxn((prevState) => {
      return { ...prevState, amount: event.target.value };
    });
  };
  const onUpdateDescription = (event) => {
    setTxn((prevState) => {
      return { ...prevState, description: event.target.value };
    });
  };
  const onUpdateNote = (event) => {
    setTxn((prevState) => {
      return { ...prevState, notes: event.target.value };
    });
  };

  const onUpdateGlAccount = (event) => {
    setTxn((prevState) => {
      return { ...prevState, gl_account_id: event.target.value };
    });
  };

  const onDeleteHandler = async (event) => {
    event.preventDefault();
    await fetch(
      `http://localhost:3000/api/v1/transactions/${event.target.value}`,
      {
        method: "DELETE",
      }
    );
    const response = await getTransactionData();
    props.setTransactions(response);
  };

  const onUpdateHandler = async (event) => {
    event.preventDefault();
    await fetch(
      `http://localhost:3000/api/v1/transactions/${event.target.value}`,
      {
        method: "PUT",
        body: JSON.stringify({ transaction: txn }),
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    const response = await getTransactionData();
    props.setTransactions(response);
  };

  return (
    <div className={classes.items}>
      <form className={txn.id}>
        <input onChange={onUpdateDate} value={txn.date}></input>
        <input onChange={onUpdateAmout} value={txn.amount}></input>
        <input
          style={{ width: "30%" }}
          onChange={onUpdateDescription}
          value={txn.description}
        ></input>
        <select onChange={onUpdateGlAccount} value={txn.gl_account_id}>
          {props.gl_accounts.map((account) => {
            return (
              <option key={account.id} value={account.id}>
                {account.name}
              </option>
            );
          })}
        </select>
        <select onChange={onUpdateNote} value={!txn.notes ? "none" : txn.notes}>
          <option value="none">Select</option>
          <option value="Need to request">need to request</option>
          <option value="Requested">requested</option>
          <option value="Paid">paid</option>
        </select>
        <button onClick={onDeleteHandler} value={txn.id}>
          Delete
        </button>
        <button onClick={onUpdateHandler} value={txn.id}>
          Update
        </button>
      </form>
    </div>
  );
};

export default TxnItem;
