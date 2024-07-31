package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Pregunta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreguntaDao {
    private Connection connection;

    public PreguntaDao() {
        // Obtener la conexión a la base de datos
        Connection getConnection = null; //Se inicializa la variable get conection
        this.connection = getConnection;  // código para obtener la conexión
    }

    public boolean insertPregunta(Pregunta pregunta) {
        try {
            // Preparar la consulta SQL para insertar una nueva pregunta
            String sql = "INSERT INTO pregunta (pregunta, tipo_pregunta_id_tipo_pregunta) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, pregunta.getPregunta());
            statement.setInt(2, pregunta.getId_tipo_pregunta());

            // Ejecutar la consulta y obtener el resultado
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            return false;
        }
    }

    public List<Pregunta> getAllPreguntas() {
        List<Pregunta> preguntas = new ArrayList<>();
        try {
            // Preparar la consulta SQL para obtener todas las preguntas
            String sql = "SELECT id_pregunta, pregunta, tipo_pregunta_id_tipo_pregunta FROM pregunta";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            // Iterar sobre los resultados y crear objetos Pregunta
            while (resultSet.next()) {
                int id_pregunta = resultSet.getInt("id_pregunta");
                String pregunta = resultSet.getString("pregunta");
                int tipo_pregunta_id_tipo_pregunta = resultSet.getInt("tipo_pregunta_id_tipo_pregunta");
                Pregunta p = new Pregunta(id_pregunta, pregunta, tipo_pregunta_id_tipo_pregunta);
                preguntas.add(p);
            }
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
        }
        return preguntas;
    }

    // Agrega otros métodos CRUD según tus necesidades
    public Pregunta getPreguntaById(int id) {
        // Implementa la lógica para obtener una pregunta por su ID
        return null;
    }

    public boolean updatePregunta(Pregunta pregunta) {
        // Implementa la lógica para actualizar una pregunta
        return false;
    }

    public boolean deletePregunta(int id) {
        // Implementa la lógica para eliminar una pregunta
        return false;
    }
}
