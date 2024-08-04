package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// data access object (DAO)
//CRUD para usuario

//Read para un usuario
public class UsuarioDao {

    //obtiene un usuario por medio del correo y contraseña, y devuelve los mismos y el id del tipo de usuario que es
    public Usuario getOne(String correo_electronico, String contrasena){
        Usuario usuario = new Usuario();
        String query = "select * from Usuario where correo_electronico = ? and contrasena = sha2(?,256);";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,correo_electronico);
            ps.setString(2,contrasena);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setCorreo_electronico(rs.getString("correo_electronico"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setId_tipo_usuario(rs.getInt("id_tipo_usuario"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //obtiene un usuario por medio del ID y regresa el ID, estado, contraseña y su correo electronico
    public Usuario getOne(int id_usuario){
        Usuario usuario = new Usuario();
        String query = "select * from Usuario where id_usuario = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_usuario);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre_usuario(rs.getString("nombre_usuario"));
                usuario.setApellido_usuario(rs.getString("apellido_usuario"));
                usuario.setCorreo_electronico(rs.getString("correo_electronico"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setEstado(rs.getInt("estado"));
                usuario.setId_tipo_usuario(rs.getInt("id_tipo_usuario"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //obtiene un usuario por medio del correo y devuelve u ID, nombre, contraseña, correo electronico y estado
    public Usuario getOne(String correo_electronico) {
        Usuario usuario = new Usuario();
        String query = "select * from Usuario where correo_electronico = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,correo_electronico);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre_usuario(rs.getString("nombre_usuario"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setCorreo_electronico(rs.getString("correo_electronico"));
                usuario.setEstado(rs.getInt("estado"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //Encargado de insertar un nuevo usuario exclusivamente para un administrador, docente o ambos
    public boolean insertDocenteAdministrativo(Usuario u){
        boolean flag = false;
        String query = "insert into usuario (nombre_usuario, apellido_usuario, correo_electronico, contrasena, codigo, fecha_registrado, tipo_usuario_id_tipo_usuario, carrera_id_carrera) values (?, ?, ?, sha2(?,256), null, now(), ?, null);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getNombre_usuario());
            ps.setString(2,u.getApellido_usuario());
            ps.setString(3,u.getCorreo_electronico());
            ps.setString(4,u.getContrasena());
            ps.setInt(5,u.getId_tipo_usuario());

            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    //Encargado de insertar un nuevo alumno
    public boolean insertAlumno(Usuario u){
        boolean flag = false;
        String query = "insert into usuario (nombre_usuario, apellido_usuario, correo_electronico, contrasena, codigo, fecha_registrado, tipo_usuario_id_tipo_usuario, carrera_id_carrera) values (?, ?, ?, sha2(?,256), null, now(), ?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getNombre_usuario());
            ps.setString(2,u.getApellido_usuario());
            ps.setString(3,u.getCorreo_electronico());
            ps.setString(4,u.getContrasena());
            ps.setInt(5,u.getId_tipo_usuario());
            ps.setInt(6,u.getId_carrera());

            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    //read para todos
    //cuando hay un select ocupamos un conjunto de resultado (result set)
    public ArrayList<Usuario> getAll(){
        ArrayList<Usuario> lista = new ArrayList<>();
        String query = "select * from Usuario";
        try {
            Connection con = DatabaseConnectionManager.getConnection(); //conección a la base
            PreparedStatement ps = con.prepareStatement(query); //preparar la base de datos
            ResultSet rs = ps.executeQuery(); //ejecutar
            while (rs.next()) { //lo ejecuta por cada ususario en la base de datos
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre_usuario(rs.getString("nombre_usuario"));
                u.setApellido_usuario(rs.getString("apellido_usuario"));
                u.setCorreo_electronico(rs.getString("correo_electronico"));
                u.setEstado(rs.getInt("estado"));
                u.setId_tipo_usuario(rs.getInt("id_tipo_usuario"));
                u.setFecha_registrado(rs.getString("fecha_registrado"));
                lista.add(u);
            }
        }catch (SQLException e){
        }
        return lista;
    }
    public boolean updateDocenteAdministrativo(Usuario u){
        boolean flag = false;
        String query = "update usuario set nombre_usuario = ?, apellido_usuario = ?, correo_electronico = ?, tipo_usuario_id_tipo_usuario = ? where id_usuario = ?";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getNombre_usuario());
            ps.setString(2,u.getApellido_usuario());
            ps.setString(3,u.getCorreo_electronico());
            ps.setInt(4,u.getId_tipo_usuario());
            ps.setInt(5,u.getId_usuario());
        }catch (SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean eliminarLogico(int id) {
        boolean flag = false;
        String query = "update usuario set estado = 0 where id = ?";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean updateCodigo(Usuario u, String codigo) {
        boolean flag = false;
        String query = "update usuario set codigo = ? where id_usuario = ?";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,codigo);
            ps.setInt(2,u.getId_usuario());
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean existe(String codigo) {
        boolean flag = false;
        String query = "select * from usuario where codigo = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,codigo);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                flag = true;
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public boolean actualizarContrasena(String contra, String codigo) {
        boolean flag = false;
        String query = "update usuario set contra = sha2(?,256), codigo = null where codigo = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,contra);
            ps.setString(2,codigo);
            UsuarioDao dao = new UsuarioDao();
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                flag = true;
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    /*
    ps.close();
    rs.close();
    con.close();

    cerrar sesiones*/


/*
    public boolean eliminarFisico(int id) {
        boolean flag = false;
        String query = "delete from usuario where id = ?";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }*/
}