//Importación de Express
var express = require("express");
//Importación de cors
var cors = require("cors");
//Importacion de cookieParser
var cookieParser = require("cookie-parser");
//Importacion del dotenv
var dotenv = require("dotenv");
 
const { send } = require("process");
 
var usuario_actual = 0;
var rolis = null;
 
//Constructor de Express
var app = express();
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cors());
app.use(cookieParser());
app.use("/resources", express.static("public"));
app.use("/resources", express.static(__dirname + "public"));
app.set("view engine", "ejs");
 
const sesion = require("express-session");
app.use(
  sesion({
    secret: "secret",
    resave: true,
    saveUninitialized: true,
  })
);
 
//llamamos a la configuración de la DB en la carpeta env
dotenv.config({ path: "./env/.env" });
 
//llamamos a la variable que fue exportada en la carpeta DB para conectar a la Base de Datos.
const conexion = require("./database/db");
const { query, application } = require("express");
 
//Importamos el JWT
const jwt = require("jsonwebtoken");
//Importamos el bcryptjs
const bcryptjs = require("bcryptjs");
//LLamamamos a la ruta donde esta la clase controller para usar el metodo isAuthenticated
const c = require("./controller/controller");
const { parseFlagList } = require("mysql/lib/ConnectionConfig");
const { parse } = require("querystring");
const { Server } = require("http");
 
//Generamos la rutas para views del login
app.get("/", (req, res) => {
  res.redirect("login");
});
app.get("/login", (req, res) => {
  res.clearCookie("jwt");
  usuario_actual = 0;
  res.render("login");
});
 
//Usuarios genericos
//Generamos la rutas para views de calender
app.get("/solicitudes", c.isAuthenticated, (req, res) => {
  if (usuario_actual == '0') { res.redirect("login"); }
  else if (rolis != null && rolis != "Usuario" && area=='Operativa' ) {
    res.redirect("solicitud");
  }
  else { res.render("solicitudes"); }
});
 


//Usuarios Admi & Super Admi
//Generamos la rutas para views de areas
//Generamos la rutas para views de empleados
app.get("/empleados", c.isAuthenticated, (req, res) => {
  if (usuario_actual == '0') { res.redirect("login"); }
  else if (rolis == "Usuario") {
    res.redirect("solicitudes");
  }
  else { res.render("empleados"); }
});

//Generamos la rutas para views de Inforformes
app.get("/informe", c.isAuthenticated, (req, res) => {
  if (usuario_actual == '0') { res.redirect("login"); }
  else if (rolis == "Usuario") {
    res.redirect("solicitudes");
  }
  else { res.render("informe"); }
});
 
//Generamos la rutas para views de solicitud
app.get("/solicitud", c.isAuthenticated, (req, res) => {
  if (usuario_actual == '0') { res.redirect("login"); }
  else if (rolis == "Usuario") {
    res.redirect("solicitudes");
  }
  else { res.render("solicitud"); }
});
 
 
//------------------------------------------ Gestión de Empleados de Clinizad ------------------------------------------
 
//Función para mostrar a los empleados de Clinizad dependiendo del tipo de rol del usuario admi
app.get("/api/empleados/:filtro", (req, res) => {
  let sql = '';
  let sql1 = 'SELECT * FROM vempleado';
  let sql2 = "SELECT * FROM vempleado WHERE nom_area = 'Administrativa'";
  let sql3 = "SELECT * FROM vempleado WHERE nom_area != 'Administrativa'";
  let filtro = req.params.filtro;

  if(filtro=='Admi'){sql = sql1;}
  else if(filtro=='Súper Admi'){sql = sql2;}
  else {sql = sql3;}

  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query(sql, filtro, (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }
  });
});


// Función para mostrar todas las sedes de Clinizad
app.get("/api/cargo",(req,res)=>{
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query("SELECT * FROM vcargos", (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas las sedes de la base de datos de sisgeva
      res.send(filas);
    }
  });
  
  });

// Función para mostrar todas las sedes de Clinizad
app.get("/api/sede",(req,res)=>{
//Consulta a la base de datos usando la sentencia sql que viene por parámetro
conexion.query("SELECT * FROM vsedes", (error, filas) => {
  //Si existe un error nos devuelve el error detectado
  if (error) {
    //Excepción con el error detectado
    throw error;
  } else {
    //Si todo está correcto nos arroja todas las sedes de la base de datos de sisgeva
    res.send(filas);
  }
});

});

// Función para mostrar todas las areas de Clinizad
app.get("/api/area",(req,res)=>{
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query("SELECT * FROM varea", (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas las areas de la base de datos de sisgeva
      res.send(filas);
    }
  });
  
  });



//Función para mostrar todos los empleados de Clinizad
app.get("/api/empleados", (req, res) => {
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query("SELECT * FROM vempleado", (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }
  });
});
 
//Función para mostrar todos los empleados de Clinizad con vacaciones disponibles
app.get("/api/listado_empleados_vac_dis/:area_s", (req, res) => {
  let area = req.params.area_s;
  let sql = '';
  let sql1 = "SELECT * FROM vempleado WHERE (dias_vac - dias_vac_apro) > 0 AND nom_area = ?"
  let sql2 = "SELECT * FROM vempleado WHERE (dias_vac - dias_vac_apro) > 0 AND nom_area != ?";
  if(area=='Todas'){sql = sql2;}
  else {sql = sql1;}
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query(sql, area,(error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }
  });
});
 
//Función para buscar un empleado por su id
app.get("/api/empleado/:id", (req, res) => {
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query("SELECT * FROM vempleado WHERE id_empleado = ?", [req.params.id], (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }
  });
});
 


//Extrae los datos del empleado en sesión.
app.get("/api/datos/", (req, res) => {
  let sql = "Select * FROM vempleado where id_empleado = ?";
  //Inserción a la base de datos usando la sentencia sql con los atributos que vienen por parámetro
  conexion.query(sql, [usuario_actual], function (err, result) {
    //Si existe un error nos devuelve el error detectado
    if (err) throw err; //Excepción con el error detectado
    else {
      //Si todo está correcto nos arroja el resultado de exito en la creación de la nueva solicitud de vacaciones
      res.send(result);
    }
  });
});

//Añade los días aprobados.
app.post("/api/anadir_dias/", (req, res) => {
  let sql = "UPDATE empleado SET dias_vac_apro = (dias_vac_apro + ?) WHERE id_empleado = ?;";
  //Inserción a la base de datos usando la sentencia sql con los atributos que vienen por parámetro
  conexion.query(sql,[req.body[0],req.body[1]], (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) throw error; //Excepción con el error detectado
    else {
      //Si todo está correcto nos arroja el resultado de exito en la creación de la nueva solicitud de vacaciones
      res.send(filas);
    }
  });
});

//Resta los días aprobados cuado se suspende la solicitud.
app.post("/api/restar_dias/", (req, res) => {
  let sql = "UPDATE empleado SET dias_vac_apro = (dias_vac_apro - ?) WHERE id_empleado = ?;";
  //Inserción a la base de datos usando la sentencia sql con los atributos que vienen por parámetro
  conexion.query(sql,[req.body[0],req.body[1]], (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) throw error; //Excepción con el error detectado
    else {
      //Si todo está correcto nos arroja el resultado de exito en la creación de la nueva solicitud de vacaciones
      res.send(filas);
    }
  });
});
 
//---------------------------------------- Gestión de Solicitudes ----------------------------------------
 
// Devuelve la cantidad de solicitudes de cada estado, del año actual del sistema
app.get("/api/cant_solicitudes_act_sis", (req, res) => {
  //Variable que almacena la sentencia de busqueda sql.
  let sql = "SELECT estado_solicitud, COUNT(*) cantidad FROM vsolicitud WHERE TIMESTAMPDIFF(YEAR, fecha_solicitud, CURDATE()) = 0 AND estado_solicitud!='Enviada' AND estado_solicitud!='En revisión' GROUP BY estado_solicitud;";
  conexion.query(sql, function (err, result) {
    //Si existe un error nos devuelve el error detectado
    if (err) {
      throw err; //Excepción con el error detectado.
    } else {
      res.send(result); 
    }
  });
});
 
// Devuelve la cantidad de solicitudes de cada estado del sistema
app.get("/api/cant_solicitudes_sis/:filtro", (req, res) => {
  //Variable que almacena la sentencia de busqueda sql.

  

  let sql = "";
  let sql1 = "SELECT estado_solicitud AS nom_estado, COUNT(*) cantidad FROM vsolicitud GROUP BY estado_solicitud";
  let sql2 = "SELECT estado_solicitud AS nom_estado, COUNT(*) cantidad FROM vsolicitud WHERE nom_area ='Administrativa' GROUP BY estado_solicitud";
  let sql3 = "SELECT estado_solicitud AS nom_estado, COUNT(*) cantidad FROM vsolicitud WHERE nom_area !='Administrativa' GROUP BY estado_solicitud";
  let filtro = req.params.filtro;

  if(filtro=='Admi'){sql = sql1;}
  if(filtro=='Súper Admi'){sql = sql2;}
  else {sql = sql3;}
   //Consulta a la base de datos usando la sentencia sql que viene por parámetro
   conexion.query(sql, (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }

})
});

// Devuelve la cantidad de solicitudes de cada estado del sistema para generar un reporte PDF
app.get("/api/reporte/:filtro", (req, res) => {
    //Variable que almacena la sentencia de busqueda sql.
 
    let estado = req.params.filtro;
  let sql ="";
  //fecha de aprobacion de las solicitudes
  let sql1 = "SELECT YEAR(vsolicitud.fecha_aprobacion) AS año, MONTH(vsolicitud.fecha_aprobacion)  AS mes, tipo_solicitud,nom_area,  COUNT(*) cantidad FROM vsolicitud  WHERE estado_solicitud='Aprobada'  GROUP BY tipo_solicitud,nom_area,mes,año"
  //fecha de rechazadas de las solicitudes
  let sql2 = "SELECT YEAR(vsolicitud.fecha_rechazo) AS año, MONTH(vsolicitud.fecha_rechazo)  AS mes, tipo_solicitud,nom_area,  COUNT(*) cantidad FROM vsolicitud  WHERE estado_solicitud='Rechazada'  GROUP BY tipo_solicitud,nom_area,mes,año"
  //fecha de rechazadas de las solicitudes
  let sql3 = "SELECT YEAR(vsolicitud.fecha_suspension) AS año, MONTH(vsolicitud.fecha_suspension)  AS mes, tipo_solicitud,nom_area,  COUNT(*) cantidad FROM vsolicitud  WHERE estado_solicitud='Suspendida'  GROUP BY tipo_solicitud,nom_area,mes,año"
  let sql4 = "SELECT YEAR(vsolicitud.fecha_solicitud) AS año, MONTH(vsolicitud.fecha_solicitud)  AS mes,estado_solicitud,tipo_solicitud,nom_area,  COUNT(*) cantidad FROM vsolicitud    GROUP BY tipo_solicitud,nom_area,mes,año";
  

  if(estado=='Aprobada'){sql = sql1;}
  else if(estado=='Rechazada'){sql = sql2;}  
  else if(estado=='Suspendida'){sql = sql3;}
  else (sql=sql4)
   //Consulta a la base de datos usando la sentencia sql que viene por parámetro
   conexion.query(sql, (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }

})
});
//Función para mostrar una sola el id del empleado
app.get("/api/solicitud/:id_empleado", (req, res) => {
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro con el id de la solicitud
  conexion.query(
    "SELECT * FROM vsolicitud WHERE id_empleado = ?",
    [req.params.id_empleado],
    (error, fila) => {
      //Si existe un error nos devuelve el error detectado
      if (error) {
        //Excepción con el error detectado
        throw error;
      } else {
        //Si todo está correcto nos arroja la solicitud con el id buscado
        res.send(fila);
      }
    }
  );
});

//Función para mostrar las solicitudes  dependiendo del tipo de rol
app.get("/api/solicitud/:filtro", (req, res) => {
  let sql = '';
  let sql1 = "SELECT * FROM vsolicitud";
  let sql2 = "SELECT * FROM vsolicitud WHERE nom_area = 'Administrativa'";
  let sql3 = "SELECT * FROM vsolicitud WHERE nom_area != 'Administrativa'";
  let filtro = req.params.filtro;

  if(filtro=='Admi'){sql = sql1;}
  else if(filtro=='Súper Admi'){sql = sql2;}
  else {sql = sql3;}

  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query(sql, (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }
  });
});
 
//Función para mostrar todos las solicitudes
app.get("/api/solicitud", (req, res) => {
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query("SELECT * FROM vsolicitud", (err, lista) => {
    //Si existe un error nos devuelve el error detectado
    if (err) {
      //Excepción con el error detectado
      throw err;
    } else {
      //Si todo está correcto nos arroja todas las solicitudes de vacaciones las cuales se encuentran almacenadas en la base de datos sisgeva
      res.send(lista);
    }
  });
});

//Función para mostrar una sola el id del empleado
app.get("/api/solicitud/:id_empleado", (req, res) => {
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro con el id de la solicitud
  conexion.query(
    "SELECT * FROM vsolicitud WHERE id_empleado = ?",
    [req.params.id_empleado],
    (error, fila) => {
      //Si existe un error nos devuelve el error detectado
      if (error) {
        //Excepción con el error detectado
        throw error;
      } else {
        //Si todo está correcto nos arroja la solicitud con el id buscado
        res.send(fila);
      }
    }
  );
});
 
//Función para mostrar las solicitudes segun su area y estado.
app.get("/api/filtrado_solicitudes/:area/:estado", (req, res) => {
  let area = req.params.area;
  let estado = req.params.estado;
  let parametros = [];
  let sql = '';
  let sql1 = "SELECT * FROM vsolicitud WHERE estado_solicitud = ? AND nom_area = ?"
  let sql2 = "SELECT * FROM vsolicitud WHERE estado_solicitud = ?";
  if(area=='Todas'){sql = sql2; parametros = [estado];}
  else {sql = sql1; parametros = [estado,area];}
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro
  conexion.query(sql, parametros, (err, lista) => {
    //Si existe un error nos devuelve el error detectado
    if (err) {
      //Excepción con el error detectado
      throw err;
    } else {
      //Si todo está correcto nos arroja todas las solicitudes de vacaciones las cuales se encuentran almacenadas en la base de datos sisgeva
      res.send(lista);
    }
  });
});
 
//Función para mostrar una sola solicitud con su código
app.get("/api/solicitud/:id_solicitud", (req, res) => {
  //Consulta a la base de datos usando la sentencia sql que viene por parámetro con el id de la solicitud
  conexion.query(
    "SELECT * FROM solicitud WHERE id = ?",
    [req.params.id_solicitud],
    (error, fila) => {
      //Si existe un error nos devuelve el error detectado
      if (error) {
        //Excepción con el error detectado
        throw error;
      } else {
        //Si todo está correcto nos arroja la solicitud con el id buscado
        res.send(fila);
      }
    }
  );
});



//Función para mostrar una sola el la peticion de solicitud por cargo para operativa
/* Action */

app.get("/api/consulta_rango/:rangosFechas", (req, res) => {

  let rango = req.params.rangosFechas;
  let sql ="";
  let sql1 = "SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-01-11' AND '2023-01-27'";
  let sql2 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-01-28' AND '2023-02-14'";
  let sql3 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-02-15' AND '2023-03-03'";
  let sql4 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-03-04' AND '2023-03-22'";
  let sql5 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-03-23' AND '2023-04-11'";
  let sql6 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-04-12' AND '2023-04-28'";
  let sql7 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-04-29' AND '2023-05-17'";
  let sql8 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-05-18' AND '2023-06-05'";
  let sql9 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-06-06' AND '2023-06-24'";
  let sql10 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-06-26' AND '2023-07-13'";
  let sql11 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-07-14' AND '2023-08-01'";
  let sql12 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-08-02' AND '2023-08-19'";
  let sql13 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-08-22' AND '2023-09-07'";
  let sql14 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-09-08' AND '2023-09-25'";
  let sql15 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-09-26' AND '2023-10-12'";
  let sql16 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-10-13' AND '2023-10-31'";
  let sql17 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-11-01' AND '2023-11-20'";
  let sql18 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-11-21' AND '2023-12-07'";
  let sql19 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-12-09' AND '2023-12-27'";
  let sql20 ="SELECT fecha_solicitud,nom_cargo FROM vsolicitud WHERE nom_area ='Operativa' AND  fecha_vac_start BETWEEN '2023-12-28' AND '2024-01-17'";  
  if(rango=='uno'){ sql =sql1;}
  else if( rango=='dos'){ sql=sql2;}
  else if(rango=='tres'){ sql=sql3;}
  else if( rango=='cuatro'){ sql=sql4;}
  else if(rango=='cinco'){ sql=sql5;}
  else if( rango=='seis'){ sql=sql6;}
  else if(rango=='siete'){ sql=sql7;}
  else if( rango=='ocho'){ sql=sql8;}
  else if(rango=='nueve'){ sql=sql9;}
  else if( rango=='diez'){ sql=sql10;}
  else if(rango=='once'){ sql=sql11;}
  else if( rango=='doce'){ sql=sql12;}
  else if(rango=='trece'){ sql=sql13;}
  else if( rango=='catorce'){ sql=sql14;}
  else if(rango=='quince'){ sql=sql15;}
  else if( rango=='dieciseis'){ sql=sql16;}
  else if(rango=='diecisiete'){ sql=sql17;}
  else if( rango=='dieciocho'){ sql=sql18;}
  else if(rango=='diecinueve'){ sql=sql19;}
  else { sql=sql20;}
  
  conexion.query(sql,rango, (error, filas) => {
    //Si existe un error nos devuelve el error detectado
    if (error) {
      //Excepción con el error detectado
      throw error;
    } else {
      //Si todo está correcto nos arroja todas los empleados de la base de datos de sisgeva
      res.send(filas);
    }
    });
});


 
//Función para crear una nueva solicitud
app.post("/api/solicitud", (req, res) => {
  //Variable que almacena la sentencia sql para su posterior consulta
  let sql = "INSERT INTO solicitud SET ?";
  //Inserción a la base de datos usando la sentencia sql con los atributos que vienen por parámetro
  conexion.query(sql, [req.body], function (err, result) {
    //Si existe un error nos devuelve el error detectado
    if (err) throw err; //Excepción con el error detectado
    else {
      //Si todo está correcto nos arroja el resultado de exito en la creación de la nueva solicitud de vacaciones
      res.send(result);
    }
  });
});
 
//Prueba de extraccion de datos de dos fechas en una columna tipo varchar
app.get("/api/solicitudes_aprobadas/:id_s", (req, res) => {
  conexion.query(
    "SELECT fecha_vac_start, fecha_vac_end FROM vsolicitud WHERE id_empleado = ?  AND estado_solicitud='Aprobada'",
    [req.params.id_s],
    function (err, result) {
      if (err) {
        throw err;
      } else {
        res.send(result);
      }
    }
  );
});
 
// Determina si el rango de fecha vacacional de la solicitud a sido registrado por un usuario del mismo cargo y sede.
app.get("/api/efecha/:cargo/:sede/:f1/:f2/:f3/:f4",(req, res) => {
  let parametros = [req.params.cargo, req.params.sede, req.params.f1, req.params.f2, req.params.f3, req.params.f4]
  let sql = "SELECT fecha_vac_start, fecha_vac_end FROM vsolicitud WHERE nom_cargo = ? AND nom_sede = ? AND ((fecha_vac_start BETWEEN ? AND ?) OR (fecha_vac_end BETWEEN ? AND ?))";
  conexion.query(sql, parametros, function (err, result) {
    if (err) {
      throw err;
    } else {
      res.send(result);
    }
  });
});

// Determina si la fecha de inicio de la solicitud a sido registrado por un usuario del mismo cargo y sede.
app.get("/api/efecha1/:cargo/:sede/:f1/:f2",(req, res) => {
  let parametros = [req.params.cargo, req.params.sede, req.params.f1, req.params.f2]
  let sql = "SELECT fecha_vac_start, fecha_vac_end FROM vsolicitud WHERE nom_cargo = ? AND nom_sede = ? AND ((fecha_vac_start <= ? && fecha_vac_end >= ?))";
  conexion.query(sql, parametros, function (err, result) {
    if (err) {
      throw err;
    } else {
      res.send(result);
    }
  });
});
 
 
//Funcion que retorna el total de solicitudes enviadas o en revision del usuario.
app.get("/api/solicitudes_enviadas/:id", (req, res) => {
  let sql =
    "SELECT COUNT(*) solicitudes_enviadas FROM empleado e, solicitud s WHERE e.id_empleado = s.id_empleado AND s.id_empleado=? AND (s.estado_solicitud!='Aprobada')";
  conexion.query(sql, [req.params.id], function (err, result) {
    if (err) {
      throw err;
    } else {
      res.send(new String(result[0].solicitudes_enviadas));
    }
  });
});
 
//Función para eliminar una solicitud con su id
app.delete("/api/solicitud/:id", (req, res) => {
  //Eliminación de un registro de la base de datos usando la sentencia sql con el id de la solicitud que viene como parámetro desde la petición
  conexion.query(
    "DELETE from solicitud WHERE id = ?",
    [req.params.id],
    function (err, result) {
      //Si existe un error nos devuelve el error detectado
      if (err) {
        //Excepción con el error detectado
        throw err;
      } else {
        //Si todo está correcto nos arroja el resultado de exito en la eliminación de la solicitud
        res.send(result);
      }
    }
  );
});
 
// Lista de días feriados fijos.
app.get("/api/feriados/", (req, res) => {
  conexion.query(
    "Select fecha_mes_dia, descripcion FROM feriados", (err, fijos) => {
      //Si existe un error nos devulve el error detectado
      if (err) {
        //Excepcón con el error detectado
        throw err;
      } else {
        //Si todo está correcto nos arroja todas las áreas de la base de datos de sisgeva
        res.send(fijos);
      }
    });
});
 
app.get("/api/es_feriado/:fecha", (req, res) => {
  conexion.query(
    "SELECT * FROM feriados where fecha_mes_dia = ?", req.params.fecha, (err, fijos) => {
      //Si existe un error nos devulve el error detectado
      if (err) {
        //Excepcón con el error detectado
        throw err;
      } else {
        //Si todo está correcto nos arroja todas las áreas de la base de datos de sisgeva
        res.send(fijos);
      }
    });
});

app.post("/api/actualizar_soli/:id", (req, res) => {
  conexion.query(
    "UPDATE solicitud set ? WHERE id = ?", [req.body, req.params.id], (err, fijos) => {
      //Si existe un error nos devulve el error detectado
      if (err) {
        //Excepcón con el error detectado
        throw err;
      } else {
        //Si todo está correcto nos arroja todas las áreas de la base de datos de sisgeva
        res.send(fijos);
      }
    });
  
});

app.delete("/api/eliminar_soli/:id", (req, res) => {
  conexion.query(
    "Delete from solicitud where id = ?", req.params.id, (err, fijos) => {
      //Si existe un error nos devulve el error detectado
      if (err) {
        //Excepcón con el error detectado
        throw err;
      } else {
        //Si todo está correcto nos arroja todas las áreas de la base de datos de sisgeva
        res.send(fijos);
      }
    });
});

app.post("/api/suspender_soli/:id", (req, res) => {
    conexion.query(
    "UPDATE solicitud set ? WHERE id = ?", [req.body, req.params.id], (err, fijos) => {
      //Si existe un error nos devulve el error detectado
      if (err) {
        //Excepcón con el error detectado
        throw err;
      } else {
        //Si todo está correcto nos arroja todas las áreas de la base de datos de sisgeva
        res.send(fijos);
      }
    });
});

//------------------------------------------ Login---------------------------------------------------

//Función para acceder con las credenciales a login

var id_empleado_logueado = 0; /* varible para guardar el id del usuario que se ingressó al sistema */

app.post("/login", async (req, res) => {
  usuario_actual = req.body.user;
  try {
    //Variables que almacenan la información que viene por la petición
    const user = req.body.user;
    const pass = req.body.password;
    //Lanza un condicion en donde pregunta que si los campos estan vacios lanse una advertencia.
    if (!user || !pass) {
      res.render("login", {
        alert: true,
        alertIcon: "info",
        alertTitle: "Advertencia",
        text: "Ingrese un usuario y contraseña",
        showConfirmButton: false,
        timer: 3000,
        ruta: "/",
      });
    } else {
      //Se ejecuta la sentencia sql donde trae los campos id, contrasena y roll del empleado
      conexion.query(
        "SELECT e.id_empleado,e.password,v.nom_rol FROM empleado e, vempleado v WHERE e.id_empleado = v.id_empleado AND e.id_empleado = ? and e.password = ?",
        [user, pass],
        async (error, results) => {
          //Lanza la condicion preguntando que si llega algo por results, sino llega nada lanza un error.
          if (results.length == 0) {
            res.render("login", {
              alert: true,
              alertTitle: "Error",
              text: "Usuario y/o contraseña incorrectos",
              alertIcon: "error",
              showConfirmButton: false,
              timer: 3000,
              ruta: "/",
            });
          } else {
            //inicio de sesión OK, guardamos la informacion en la variable id
            const id = results[0].id_empleado;

            id_empleado_logueado = id; //Guarda el id del empleado que ingresó al sistema en la variable global

            // Generamos el token con los datos que estan en env
            const token = jwt.sign(
              { id_empleado: id },
              process.env.JWT_SECRETO,
              {
                expiresIn: process.env.JWT_TIEMPO_EXPIRA,
              }
            );
            //generamos el token SIN fecha de expiracion
            //const token = jwt.sign({id: id}, process.env.JWT_SECRETO)
            console.log("TOKEN: " + token + " para el USUARIO : " + user);
 
            // Controla el tiempo en el que esta disponible el JWT para la sesión
            const cookiesOptions = {
              expires: new Date(
                Date.now() +
                process.env.JWT_COOKIE_EXPIRES * 24 * 60 * 60 * 1000
              ),
              httpOnly: true,
            };
            res.cookie("jwt", token, cookiesOptions);
            // Guardamos la información en la variable rol, esta tiene los roles de los empleados
            const rol = results[0].nom_rol;
            rolis = rol;
            //Lanza la condicion donde el usser y pass ingresados tienen roll de admin los lleva a areas
            if (rol == "Usuario") {
              res.render("login", {
                alert: true,
                alertTitle: "Conexión exitosa",
                text: "",
                alertIcon: "success",
                showConfirmButton: false,
                timer: 3000,
                ruta: "solicitudes",
              });
            } else {
              conexion.query(
                "SELECT (TIMESTAMPDIFF(YEAR,fechaContrato, CURDATE())) periodos_trabajo FROM vempleado WHERE id_empleado = ?",
                [user],
                async (error, results1) => {
                  var periodos_trabajo = parseInt(results1[0].periodos_trabajo);
 
                  if (periodos_trabajo > 0) {
                    // De lo contrario los redirecciona a la vista solicitudes.
                    res.render("login", {
                      alert: true,
                      alertTitle: "Conexión exitosa",
                      text: "",
                      alertIcon: "success",
                      showConfirmButton: false,
                      timer: 00,
                      ruta: "solicitud",
                    });
                  } else {
                    res.render("login", {
                      alert: true,
                      alertTitle: "Error",
                      text: "No cumple con los periodos de trabajo necesarios para acceder al sistema.",
                      alertIcon: "error",
                      showConfirmButton: false,
                      timer: 3000,
                      ruta: "/",
                    });
                  }
                }
              );
            }
          }
        }
      );
    }
    //caputura el error
  } catch (error) {
    console.log(error);
  }
});


app.get("/logout", (req, res) => {
  usuario_actual = 0;
  rolis = null;
  res.clearCookie("jwt");
  res.redirect('/login');
});


/*--------- Funcion para cambiar contraseñas----------*/

app.put('/api/usuarios/:id/password', (req, res) => {
  const id = id_empleado_logueado;
  const password = req.body.password;

  const sqlUpdate = "UPDATE empleado SET password = '${password}' WHERE id_empleados = ${id}";
  
  connection.query(sql, (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error actualizando la contraseña');
    } else {
      res.send('Contraseña actualizada correctamente');
    }
  });
});


//------------------------------------------Conexión del servidor------------------------------------------
//Inicializamos el server, y le decimos que escuche por el port 3000
app.listen(3000, (req, res) => {
  console.log("servidor run");
});