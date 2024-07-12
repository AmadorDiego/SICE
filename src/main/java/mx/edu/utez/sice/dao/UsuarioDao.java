package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsuarioDao {
// data access object (DAO)
    //CRUD para usuario
    //Read para un usuario
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
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //obtiene la información de un usuario por ID
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
                usuario.setEstado(rs.getBoolean("estado"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setCorreo_electronico(rs.getString("correo_electronico"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //Encargaco de insertar un nuevo usuario
    public boolean insert(Usuario u){
        boolean flag = false;
        String query = "insert into usuario(nombre,contrasena,correo_electronico) values (?,sha2(?,256),?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getNombre());
            ps.setString(2,u.getContrasena());
            ps.setString(3,u.getCorreo_electronico());
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
                u.setCorreo_electronico(rs.getString("correo_electronico"));
                u.setContrasena(rs.getString("contrasena"));
                u.setEstado(rs.getBoolean("estado"));
                lista.add(u);
            }
        }catch (SQLException e){

        }
        return lista;
    }
    public boolean update(Usuario u){
        boolean flag = false;
        String query = "update usuario set nombre = ?, contrasena = ?, correo_electronico = ? where id_usuario = ?";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getNombre());
            ps.setString(2, u.getContrasena());
            ps.setString(3);
        }catch (SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

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
    }

    public boolean eliminarLogico(int id) {
        boolean flag = false;
        String query = "update usuario set estado = false where id = ?";
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

    public Usuario getOne(String correo) {
        Usuario usuario = new Usuario();
        String query = "select * from Usuario where correo = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,correo);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                usuario.setId_usuario(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setContrasena(rs.getString("contra"));
                usuario.setCorreo_electronico(rs.getString("correo"));
                usuario.setEstado(rs.getBoolean("estado"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    public boolean updateCodigo(Usuario u, String codigo) {
        boolean flag = false;
        String query = "update usuario set codigo = ? where id = ?";
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

}