package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.UsuarioDao;
import mx.edu.utez.sice.model.Usuario;

import java.io.IOException;

@WebServlet (name = "CambiarContrasenaServlet", value = "/CambiarContrasenaServlet")
public class CambiarContrasenaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        UsuarioDao usuarioDao = new UsuarioDao();
        Usuario usuario = usuarioDao.getOne(id_usuario);
        HttpSession sesion = req.getSession();
        String mensaje;
        System.out.println(usuario.getId_usuario());
        if(req.getParameter("contrasena1").equals(req.getParameter("contrasena2"))){
            String contrasena = (req.getParameter("contrasena1"));
            if (usuarioDao.updateContrasena(contrasena, id_usuario)){
                sesion.setAttribute("flag", true);
                mensaje = "Se restauro tu contraseña con éxito.";
                switch (usuario.getId_tipo_usuario()){
                    case 1:
                        resp.sendRedirect("JSP/Administrador/perfilAdministrador.jsp");
                        sesion.setAttribute("mensajeAdministrador", mensaje);
                        break;
                    case 2:
                        resp.sendRedirect("JSP/Docente/perfilDocente.jsp");
                        sesion.setAttribute("mensajeDocente", mensaje);
                        break;
                    case 3:
                        resp.sendRedirect("JSP/Alumno/perfilAlumno.jsp");
                        sesion.setAttribute("mensajeAlumno", mensaje);
                        break;
                    case 4:
                        resp.sendRedirect("JSP/Docente-Administrador/perfilDocenteAdministrador.jsp");
                        sesion.setAttribute("mensajeDocenteAdministrador", mensaje);
                        break;
                }
            }
        }else{
            sesion.setAttribute("flag", false);
            mensaje = "Las contraseñas no coinciden, intentalo de nuevo";
            switch (usuario.getId_tipo_usuario()){
                case 1:
                    resp.sendRedirect("JSP/Administrador/perfilAdministrador.jsp");
                    sesion.setAttribute("mensajeAdministrador", mensaje);
                    break;
                    case 2:
                        resp.sendRedirect("JSP/Docente/perfilDocente.jsp");
                        sesion.setAttribute("mensajeDocente", mensaje);
                        break;
                        case 3:
                            resp.sendRedirect("JSP/Alumno/perfilAlumno.jsp");
                            sesion.setAttribute("mensajeAlumno", mensaje);
                            break;
                            case 4:
                                resp.sendRedirect("JSP/Docente-Administrador/perfilDocenteAdministrador.jsp");
                                sesion.setAttribute("mensajeDocenteAdministrador", mensaje);
                                break;
            }
        }
    }
}
