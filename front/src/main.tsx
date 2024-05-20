import "./global.css";

import React from "react";
import ReactDOM from "react-dom/client";
import { Menu } from "./menu/Menu";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <Menu />
  </React.StrictMode>
);
