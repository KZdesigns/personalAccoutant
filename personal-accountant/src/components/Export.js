import React from "react";

const Export = () => {
  const onExportHandler = async (event) => {
    await fetch("http://localhost:3000/api/v1/transactions/export");
  };

  return <button onClick={onExportHandler}>Export</button>;
};

export default Export;
