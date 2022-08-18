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

  const onUpdateHandler = async (even) => {
    // TODO: write function for updating transactions
    // PUT    /api/v1/transactions/:id(.:format)
  };

  return (
    <div>
      <h1>This Transaction are from the API</h1>
      {props.transactions.map((txn) => {
        return (
          <div key={txn.id}>
            <form>
              <input type="text" defaultValue={txn.date}></input>
              <input type="text" defaultValue={txn.amount}></input>
              <input type="text" defaultValue={txn.description}></input>
              <select>
                <option value="none" defaultChecked></option>
                <option value="need to request">need to request</option>
                <option value="need to request">requested</option>
                <option value="need to request">paid</option>
              </select>
              <button onClick={onDeleteHandler} value={txn.id}>
                Delete
              </button>
              <button onClick={onUpdateHandler}>Update Txn</button>
            </form>
          </div>
        );
      })}
    </div>
  );
};

export default Transactions;
