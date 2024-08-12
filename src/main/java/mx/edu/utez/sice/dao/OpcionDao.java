package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OpcionDao {
    private Connection connection;

    public OpcionDao() {
        // Obtener la conexión a la base de datos
        this.connection = getConnection();
    }

    private Connection getConnection() {
        try {
            // Obtener la conexión del pool de conexiones
            return DatabaseConnectionManager.getConnection();
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return null;
        }
    }

    /*public boolean insertOpcion(Opcion opcion) {
        try {
            // Preparar la consulta SQL para insertar una nueva opción
            String sql = "INSERT INTO opcion (opcion) VALUES (?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, opcion.getOpcion());

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }*/
    public boolean insertOpcion(Opcion opcion){
        boolean flag = false;
        String query = "INSERT INTO opcion (opcion) VALUES (?)";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,opcion.getOpcion());
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public int getOne(Opcion opcion){
        int id_opcion = 0;
        String query = "SELECT id_opcion FROM opcion where opcion = ? order by id_opcion desc limit 1;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,opcion.getOpcion());
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                id_opcion = (rs.getInt("id_opcion"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id_opcion;
    }
/*
    public List<Opcion> getAllOpciones() {
        List<Opcion> opciones = new ArrayList<>();
        try {
            // Preparar la consulta SQL para obtener todas las opciones
            String sql = "SELECT id_opcion, opcion FROM opcion";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            // Iterar sobre los resultados y crear objetos Opcion
            while (resultSet.next()) {
                int id_opcion = resultSet.getInt("id_opcion");
                String opcion = resultSet.getString("opcion");
                Opcion o = new Opcion(id_opcion, opcion);
                opciones.add(o);
            }
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
        }
        return opciones;
    }

    public Opcion getOpcionById(int id) {
        Opcion opcion = null;
        try {
            // Preparar la consulta SQL para obtener una opción por su ID
            String sql = "SELECT id_opcion, opcion FROM opcion WHERE id_opcion = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);

            // Ejecutar la consulta y obtener el resultado
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                int id_opcion = resultSet.getInt("id_opcion");
                String opcionText = resultSet.getString("opcion");
                opcion = new Opcion(id_opcion, opcionText);
            }
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
        }
        return opcion;
    }

    public boolean updateOpcion(Opcion opcion) {
        try {
            // Preparar la consulta SQL para actualizar una opción
            String sql = "UPDATE opcion SET opcion = ? WHERE id_opcion = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, opcion.getOpcion());
            statement.setInt(2, opcion.getId_opcion());

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteOpcion(int id) {
        try {
            // Preparar la consulta SQL para eliminar una opción
            String sql = "DELETE FROM opcion WHERE id_opcion = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }*/
}