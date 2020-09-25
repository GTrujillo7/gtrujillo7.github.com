import express from "express";
import morgan from "morgan";
import cors from "cors";

// PARA ACCEDER AL DIRECTORIO ACTUAL
import path from "path";

const app = express()

// Conexion a DB
//const mongoose require("mongoose");
//const uri = "mongodb://localhost:27017/udemy";

// conexion en la nube
const mongoose = require("mongoose");
const uri = "mongodb+srv://user_udemy:DZHtYNFjBQlKJ6ek@cluster0.inot0.mongodb.net/udemy?retryWrites=true&w=majority";

const options = {
  useNewUrlParser: true , useCreateIndex: true, useUnifiedTopology: true
}
mongoose.connect(uri, options).then(
  () => { console.log('Conectado a mongo');},
  err => { err }
);

app.use(morgan("tiny"));
app.use(cors());
app.use(express.json());
//aplication/x-www-form-urlencoded
app.use(express.urlencoded({extended: true}));


//RUTAS
//app.get('/', (req, res) => {
  //res.send('Hello World! amiko')
//});

app.use("/api", require("./routes/nota"));

// MIDDLEWARE para vue.js router modo history
const history = require("connect-history-api-fallback");
app.use(history());
app.use(express.static(path.join(__dirname, "public")));

app.set("puerto", process.env.PORT || 4000);
app.listen(app.get("puerto"), () => {
  console.log("Escuchando el puerto: " , app.get("puerto"));
});
