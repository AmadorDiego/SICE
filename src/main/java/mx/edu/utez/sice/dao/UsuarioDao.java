package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Examen;
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
        String query = "select * from usuario where correo_electronico = ? and contrasena = sha2(?,256);";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,correo_electronico);
            ps.setString(2,contrasena);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setCorreo_electronico(rs.getString("correo_electronico"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setId_tipo_usuario(rs.getInt("id_tipo_usuario"));
                usuario.setNombre_usuario(rs.getString("nombre_usuario"));
                usuario.setApellido_usuario(rs.getString("apellido_usuario"));            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //obtiene un usuario por medio del ID y regresa el ID, estado, contraseña y su correo electronico
    public Usuario getOne(int id_usuario){
        Usuario usuario = new Usuario();
        String query = "select * from usuario where id_usuario = ?;";
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
                usuario.setFecha_registrado(rs.getString("fecha_registrado"));
                //en caso de que el ID del tipo de usuario obtenido sea 3 (un alumno), seteamos el ID de su carrera
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    public Usuario getDocentePorExamen(int id_examen){
        Usuario usuario = new Usuario();
        String query = "select nombre_usuario, apellido_usuario from usuario join usuario_tiene_examen on id_usuario = usuario_id_usuario where examen_id_examen = ? and id_tipo_usuario = 2;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setNombre_usuario(rs.getString("nombre_usuario"));
                usuario.setApellido_usuario(rs.getString("apellido_usuario"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //obtiene un usuario por medio del correo y devuelve u ID, nombre, contraseña, correo electronico y estado
    public Usuario getOne(String correo_electronico) {
        Usuario usuario = new Usuario();
        String query = "select * from usuario where correo_electronico = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,correo_electronico);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre_usuario(rs.getString("nombre_usuario"));
                usuario.setApellido_usuario(rs.getString("apellido_usuario"));
                usuario.setCorreo_electronico(rs.getString("correo_electronico"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setEstado(rs.getInt("estado"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    public boolean insertUsuario(Usuario u){
        boolean flag = false;
        String query = "insert into usuario (nombre_usuario, apellido_usuario, correo_electronico, contrasena, estado, fecha_registrado, codigo, id_tipo_usuario) values (?, ?, ?, sha2(?,256), 1, now(), null, ?);";
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

            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    //read para todos
    //cuando hay un select ocupamos un conjunto de resultado (result set)
    public ArrayList<Usuario> getAll(){
        ArrayList<Usuario> lista = new ArrayList<>();
        String query = "select * from usuario";
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
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Usuario> getAllAlumnosConGrupo(int id_grupo){
        ArrayList<Usuario> lista = new ArrayList<>();
        String query = "select id_usuario, nombre_usuario, apellido_usuario, correo_electronico from usuario join usuario_tiene_grupo on id_usuario = usuario_id_usuario where grupo_id_grupo = ? and id_tipo_usuario = 3 order by apellido_usuario;";
        try {
            Connection con = DatabaseConnectionManager.getConnection(); //conección a la base
            PreparedStatement ps = con.prepareStatement(query); //preparar la base de datos
            ps.setInt(1,id_grupo);
            ResultSet rs = ps.executeQuery(); //ejecutar
            while (rs.next()) { //lo ejecuta por cada ususario en la base de datos
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre_usuario(rs.getString("nombre_usuario"));
                u.setApellido_usuario(rs.getString("apellido_usuario"));
                u.setCorreo_electronico(rs.getString("correo_electronico"));
                lista.add(u);
            }
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Usuario> getAllUsuariosConGrupo(int id_grupo){
        ArrayList<Usuario> lista = new ArrayList<>();
        String query = "select id_usuario, nombre_usuario, apellido_usuario, correo_electronico from usuario join usuario_tiene_grupo on id_usuario = usuario_id_usuario where grupo_id_grupo = ? order by apellido_usuario;";
        try {
            Connection con = DatabaseConnectionManager.getConnection(); //conección a la base
            PreparedStatement ps = con.prepareStatement(query); //preparar la base de datos
            ps.setInt(1,id_grupo);
            ResultSet rs = ps.executeQuery(); //ejecutar
            while (rs.next()) { //lo ejecuta por cada ususario en la base de datos
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre_usuario(rs.getString("nombre_usuario"));
                u.setApellido_usuario(rs.getString("apellido_usuario"));
                u.setCorreo_electronico(rs.getString("correo_electronico"));
                lista.add(u);
            }
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Usuario> getAllAlumnosSinGrupo(){
        ArrayList<Usuario> lista = new ArrayList<>();
        String query = "SELECT id_usuario, nombre_usuario, apellido_usuario, correo_electronico, estado FROM usuario LEFT JOIN usuario_tiene_grupo ON id_usuario = usuario_id_usuario WHERE id_tipo_usuario = 3 AND usuario_id_usuario IS NULL;";
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
                lista.add(u);
            }
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e){
        }
        return lista;
    }

    public ArrayList<Usuario> getAllAlumnosExamenContestado(int id_examen){
        ArrayList<Usuario> lista = new ArrayList<>();
        String query = "SELECT u.id_usuario, u.nombre_usuario, u.apellido_usuario, u.correo_electronico FROM sice.usuario u JOIN sice.usuario_tiene_examen ute ON u.id_usuario = ute.usuario_id_usuario WHERE ute.examen_id_examen = ? AND ute.estado = 2 and u.id_tipo_usuario = 3;";
        try {
            Connection con = DatabaseConnectionManager.getConnection(); //conección a la base
            PreparedStatement ps = con.prepareStatement(query); //preparar la base de datos
            ps.setInt(1,id_examen);
            ResultSet rs = ps.executeQuery(); //ejecutar
            while (rs.next()) { //lo ejecuta por cada ususario en la base de datos
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre_usuario(rs.getString("nombre_usuario"));
                u.setApellido_usuario(rs.getString("apellido_usuario"));
                u.setCorreo_electronico(rs.getString("correo_electronico"));
                lista.add(u);
            }
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e){
        }
        return lista;
    }

    public boolean updateUsuario(Usuario u){
        boolean flag = false;
        String query = "update usuario set nombre_usuario = ?, apellido_usuario = ?, correo_electronico = ?, estado = ?, id_tipo_usuario = ? where id_usuario = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getNombre_usuario());
            ps.setString(2,u.getApellido_usuario());
            ps.setString(3,u.getCorreo_electronico());
            ps.setInt(4,u.getEstado());
            ps.setInt(5,u.getId_tipo_usuario());
            ps.setInt(6,u.getId_usuario());
            if(ps.executeUpdate()>0){
                flag = true;
            }
            ps.close();
            con.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean eliminarLogico(int id_usuario) {
        boolean flag = false;
        String query = "update usuario set estado = 0 where id_usuario = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_usuario);
            if(ps.executeUpdate()>0){
                flag = true;
            }

            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }
    public boolean restaurarUsuario(int id_usuario) {
        boolean flag = false;
        String query = "update usuario set estado = 1 where id_usuario = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_usuario);
            if(ps.executeUpdate()>0){
                flag = true;
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            ps.close();
            con.close();
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
            ps.close();
            con.close();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public boolean actualizarContrasena(String contra, String codigo) {
        boolean flag = false;
        String query = "update usuario set contrasena = sha2(?,256), codigo = null where codigo = ?;";
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
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public Boolean updateContrasena(String contrasena, int id_usuario) {
        boolean flag = false;
        String query = "update usuario set contrasena = sha2(?,256) where id_usuario = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, contrasena);
            ps.setInt(2, id_usuario);
            int rowsUpdated = ps.executeUpdate(); // Cambia a executeUpdate()
            if (rowsUpdated > 0) {
                flag = true;
            }
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

}