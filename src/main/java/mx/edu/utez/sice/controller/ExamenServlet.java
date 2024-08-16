package mx.edu.utez.sice.controller;

import com.google.api.client.googleapis.json.GoogleJsonError;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.OpcionDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.dao.PreguntaOpcionDao;
import mx.edu.utez.sice.model.*;
import org.apache.poi.sl.draw.geom.GuideIf;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet (name="ExamenServlet", value = "/ExamenServlet")
public class ExamenServlet extends HttpServlet {
    /*protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("crear".equals(action)) {
            // Preparar para la creación de un nuevo examen
            request.setAttribute("modo", "crear");
            request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
        } else {
            // Lógica existente para mostrar todos los exámenes
            ExamenDao dao = new ExamenDao();
            List<Examen> examenes = dao.getAll();
            request.setAttribute("examenes", examenes);
            request.setAttribute("modo", "listar");
            request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
        }
    }*/

    /*protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ExamenDao examenDao = new ExamenDao();
        ArrayList<Examen>examenes = examenDao.getAll();

        System.out.println("Número de exámenes recuperados: " + examenes.size());
        for (Examen examen : examenes) {
            System.out.println("Examen: " + examen.getNombre_examen()
                    + ", Descripción: " + examen.getDescripcion());
        }
            req.setAttribute("examenes", examenes);
            req.getRequestDispatcher("JSP/Docente/indexDocente.jsp").forward(req, resp);
    }*/

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean flag = false;
        //Creamos un nuevo examen obteniendo los datos necesarios para su creación
        Examen examen = new Examen();
        examen.setNombre_examen(req.getParameter("nombre_examen"));
        examen.setCantidad_preguntas(Integer.parseInt(req.getParameter("cantidad_preguntas")));
        examen.setEstado(0);
        examen.setDescripcion((req.getParameter("descripcion")));
        examen.setId_usuario((Integer.parseInt(req.getParameter("id_usuario"))));

        //creamos un ExamenDao para mandar a llamar el método insertExamen, pasando como parametro el examen creado anteriormente
        HttpSession sesion = req.getSession();
        ExamenDao dao = new ExamenDao();
        //obtenemos el resultado de la inserción (registro exitoso o error al registrar)
        //si no se crea el examen, no creamos las preguntas ni sus opciones
        if (dao.insertExamen(examen)){
            //obtenemos el id del examen por medio de los atributos que generamos anteriormente
            int id_examen = dao.getOne(examen);

            //creamos arreglos para obtener todas las preguntas y todos sus tipos
            String[] preguntas = req.getParameterValues("texto_pregunta[]");
            String[] tipos = req.getParameterValues("id_tipo_pregunta[]");
            //creamos el arraylist que nos permitira llenar la tabla de intersección en la base de datos, llamada "examen_tiene_pregunta"
            ArrayList<Integer> examen_tiene_preguntas = new ArrayList<>();

            //creamos un for para que vayamos guardando la pregunta y el id del tipo de pregunta que le corresponde, con ayuda de los metodos "set"
            for (int i = 0; i < preguntas.length; i++) {
                //creamos una pregunta y guardamos la pregunta y su tipo
                Pregunta pregunta = new Pregunta();
                pregunta.setPregunta(preguntas[i]);
                pregunta.setId_tipo_pregunta(Integer.parseInt(tipos[i]));

                //creamos un PreguntaDao para mandar a llamar el método insertPregunta, pasando como parametro la pregunta creada anteriormente justo ahora
                PreguntaDao preguntaDao = new PreguntaDao();
                if (preguntaDao.insertPregunta(pregunta)){
                    //obtenemos el id de la pregunta por medio de los atributos que generamos anteriormente
                    int id_pregunta = preguntaDao.getOne(pregunta);
                    //añadimos el id de la pregunta al arraylist
                    flag = examen_tiene_preguntas.add(id_pregunta);

                    //si la pregunta es cerrada, entonces guardamos las opciones que tiene
                    if (pregunta.getId_tipo_pregunta() == 2) { // Pregunta cerrada
                        //creamos un arreglo para obtener todas las opciones de la pregunta
                        String[] opciones = req.getParameterValues("opcion_" + (i + 1) + "[]");
                        String opcionCorrecta = req.getParameter("opcion_correcta_" + (i + 1));
                        //creamos el arraylist que nos permitira llenar la tabla de intersección en la base de datos, llamada "pregunta_opcion"
                        ArrayList<Integer> pregunta_opcion= new ArrayList<>();

                        for (int j = 0; j < opciones.length; j++) {
                            //creamos una opcion y guardamos la misma
                            Opcion opcion = new Opcion();
                            opcion.setOpcion(opciones[j]);

                            //creamos un OpcionDao para mandar a llamar el método insertOpcion, pasando como parametro la opción creada anteriormente justo ahora
                            OpcionDao opcionDao = new OpcionDao();
                            if (opcionDao.insertOpcion(opcion)){
                                //obtenemos el id de la opción por medio de la misma opción que generamos anteriormente
                                int id_opcion = opcionDao.getOne(opcion);
                                //añadimos el id de la opcion al arraylist
                                pregunta_opcion.add(id_opcion);

                                //creamos una preguntaOpcion con los id de la pregunta, la opción y el campo para verificar que sea correcta la opción
                                PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
                                preguntaOpcion.setId_opcion(id_opcion);
                                preguntaOpcion.setId_pregunta(id_pregunta);
                                preguntaOpcion.setCorrecta(opcionCorrecta.equals(String.valueOf(j + 1)) ? 1 : 0); // Cambiado a int
                                //guardamos la informacion en un método "insertPreguntaOpcion" ubicado en preguntaDao
                                //para llenar la tabla de intersección llamada "pregunta_opcion"
                                flag = preguntaDao.insertPreguntaOpcion(preguntaOpcion);
                            }
                        }
                        //guardamos el arraylist llamado "pregunta_opcion" en el arraylist llamado "opciones" que está ubicado en "pregunta.java"
                        pregunta.setOpciones(pregunta_opcion);
                    }
                }

            }
            //guardamos el arraylist llamado "examen_tiene_preguntas" en el arraylist llamado "preguntas" que está ubicado en "examen.java"
            examen.setPreguntas(examen_tiene_preguntas);
            //hacemos una insercion en la tabla "examen_tiene_pregunta" por medio del arraylist "preguntas" llenado con el arraylist "examen_tiene_preguntas"
            for (int i = 0; i < examen.getPreguntas().size(); i++) {
                int id_pregunta = examen.getPreguntas().get(i);
                dao.insertExamenPreguntas(id_examen, id_pregunta);
            }
            if (flag) {
                sesion.setAttribute("mensaje","Examen creado exitosamente");
                sesion.setAttribute("flag", true);
                resp.sendRedirect("JSP/Docente/personalizarExamen.jsp");
            } else {
                sesion.setAttribute("mensaje","Ocurrio un error al crear el examen");
                sesion.setAttribute("flag", false);
                resp.sendRedirect("JSP/Docente/indexDocente.jsp");
            }
        }
    }
}