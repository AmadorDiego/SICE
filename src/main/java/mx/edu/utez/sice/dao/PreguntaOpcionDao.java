package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreguntaOpcionDao {
    private Connection connection;

    public PreguntaOpcionDao() {
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

    public boolean insertPreguntaOpcion(PreguntaOpcion preguntaOpcion) {
        try {
            // Preparar la consulta SQL para insertar una nueva relación pregunta-opción
            String sql = "INSERT INTO pregunta_opcion (pregunta_id_pregunta, opcion_id_opcion, correcta) VALUES (?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, preguntaOpcion.getId_pregunta());
            statement.setInt(2, preguntaOpcion.getId_opcion());
            statement.setBoolean(3, preguntaOpcion.isCorrecta());

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }

    public List<PreguntaOpcion> getAllPreguntaOpciones() {
        List<PreguntaOpcion> preguntaOpciones = new ArrayList<>();
        try {
            // Preparar la consulta SQL para obtener todas las relaciones pregunta-opción
            String sql = "SELECT pregunta_id_pregunta, opcion_id_opcion, correcta FROM pregunta_opcion";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            // Iterar sobre los resultados y crear objetos PreguntaOpcion
            while (resultSet.next()) {
                int pregunta_id_pregunta = resultSet.getInt("pregunta_id_pregunta");
                int opcion_id_opcion = resultSet.getInt("opcion_id_opcion");
                boolean correcta = resultSet.getBoolean("correcta");
                PreguntaOpcion po = new PreguntaOpcion(pregunta_id_pregunta, opcion_id_opcion, correcta);
                preguntaOpciones.add(po);
            }
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
        }
        return preguntaOpciones;
    }

    public List<PreguntaOpcion> getPreguntaOpcionesByPreguntaId(int preguntaId) {
        List<PreguntaOpcion> preguntaOpciones = new ArrayList<>();
        try {
            // Preparar la consulta SQL para obtener las opciones asociadas a una pregunta
            String sql = "SELECT pregunta_id_pregunta, opcion_id_opcion, correcta FROM pregunta_opcion WHERE pregunta_id_pregunta = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, preguntaId);

            // Ejecutar la consulta y obtener el resultado
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int pregunta_id_pregunta = resultSet.getInt("pregunta_id_pregunta");
                int opcion_id_opcion = resultSet.getInt("opcion_id_opcion");
                boolean correcta = resultSet.getBoolean("correcta");
                PreguntaOpcion po = new PreguntaOpcion(pregunta_id_pregunta, opcion_id_opcion, correcta);
                preguntaOpciones.add(po);
            }
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
        }
        return preguntaOpciones;
    }

    public boolean updatePreguntaOpcion(PreguntaOpcion preguntaOpcion) {
        try {
            // Preparar la consulta SQL para actualizar una relación pregunta-opción
            String sql = "UPDATE pregunta_opcion SET correcta = ? WHERE pregunta_id_pregunta = ? AND opcion_id_opcion = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setBoolean(1, preguntaOpcion.isCorrecta());
            statement.setInt(2, preguntaOpcion.getId_pregunta());
            statement.setInt(3, preguntaOpcion.getId_opcion());

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePreguntaOpcion(int preguntaId, int opcionId) {
        try {
            // Preparar la consulta SQL para eliminar una relación pregunta-opción
            String sql = "DELETE FROM pregunta_opcion WHERE pregunta_id_pregunta = ? AND opcion_id_opcion = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, preguntaId);
            statement.setInt(2, opcionId);

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }
}
