import React, { useRef, useState } from "react";

const Form = (props) => {
  const [csv, setFile] = useState();
  const userInput = useRef("");

  const handleUpload = async (event) => {
    event.preventDefault();
    const formData = new FormData();
    const file = csv;
    formData.append("file", file);
    await fetch("http://localhost:3000/api/v1/transactions/import", {
      method: "POST",
      body: formData,
    });
    props.setFile(true);
    userInput.current.value = null;
  };

  const fileChangeHanlder = (event) => {
    setFile(event.target.files[0]);
  };

  return (
    <div>
      <form onSubmit={handleUpload}>
        <input
          type="file"
          name="file"
          onChange={fileChangeHanlder}
          ref={userInput}
        ></input>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
};

export default Form;
