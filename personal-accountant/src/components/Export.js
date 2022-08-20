import React from "react";

const Export = () => {
  const onExportHandler = async (event) => {
    const response = await fetch(
      "http://localhost:3000/api/v1/transactions/export.csv"
    );
    console.log(response);
  };

  return <button onClick={onExportHandler}>Export</button>;
};

export default Export;
