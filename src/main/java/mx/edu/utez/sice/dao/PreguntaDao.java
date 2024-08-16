package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;

public class PreguntaDao {
    private Connection connection;

    public PreguntaDao() {
        // Obtener la conexión a la base de datos
        Connection getConnection = null; // Se inicializa la variable getConnection
        this.connection = getConnection;  // código para obtener la conexión
    }

    /*public boolean insertPregunta(Pregunta pregunta) {
        try {
            String query = "INSERT INTO pregunta (pregunta, tipo_pregunta_id_tipo_pregunta) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, pregunta.getPregunta());
            statement.setInt(2, pregunta.getId_tipo_pregunta());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                // Obtener el ID generado
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    pregunta.setId_pregunta(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }*/
    public boolean insertPregunta(Pregunta pregunta){
        boolean flag = false;
        String query = "INSERT INTO pregunta (pregunta, id_tipo_pregunta) VALUES (?, ?)";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,pregunta.getPregunta());
            ps.setInt(2,pregunta.getId_tipo_pregunta());
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean insertPreguntaOpcion(PreguntaOpcion preguntaOpcion){
        boolean flag = false;
        String query = "INSERT INTO pregunta_opcion (pregunta_id_pregunta, opcion_id_opcion, correcta) VALUES (?, ?, ?)";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,preguntaOpcion.getId_pregunta());
            ps.setInt(2,preguntaOpcion.getId_opcion());
            ps.setInt(3,preguntaOpcion.getCorrecta());
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public int getOne(Pregunta pregunta){
        int id_pregunta = 0;
        String query = "SELECT id_pregunta FROM pregunta where pregunta = ? and id_tipo_pregunta = ? order by id_pregunta desc limit 1;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,pregunta.getPregunta());
            ps.setInt(2,pregunta.getId_tipo_pregunta());
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                id_pregunta = (rs.getInt("id_pregunta"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id_pregunta;
    }

    public ArrayList<Pregunta> getAll(int id_examen) {
        ArrayList<Pregunta> listaPreguntas = new ArrayList<>();
        String query = "select id_pregunta, pregunta, id_tipo_pregunta from pregunta join examen_tiene_pregunta on id_pregunta = pregunta_id_pregunta " +
                "join examen on examen_id_examen = id_examen where id_examen = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_examen);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pregunta pregunta = new Pregunta();
                pregunta.setId_pregunta(rs.getInt("id_pregunta"));
                pregunta.setPregunta(rs.getString("pregunta"));
                pregunta.setId_tipo_pregunta(rs.getInt("id_tipo_pregunta"));
                listaPreguntas.add(pregunta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPreguntas;
    }

/*
    public boolean updatePregunta(Pregunta pregunta) {
        try {
            String query = "UPDATE pregunta SET pregunta = ?, tipo_pregunta_id_tipo_pregunta = ? WHERE id_pregunta = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, pregunta.getPregunta());
            statement.setInt(2, pregunta.getId_tipo_pregunta());
            statement.setInt(3, pregunta.getId_pregunta());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePregunta(int idPregunta) {
        try {
            // Primero, eliminar las relaciones en la tabla examen_tiene_pregunta
            String deleteRelationQuery = "DELETE FROM examen_tiene_pregunta WHERE pregunta_id_pregunta = ?";
            PreparedStatement deleteRelationStatement = connection.prepareStatement(deleteRelationQuery);
            deleteRelationStatement.setInt(1, idPregunta);
            deleteRelationStatement.executeUpdate();

            // Luego, eliminar la pregunta
            String deletePreguntaQuery = "DELETE FROM pregunta WHERE id_pregunta = ?";
            PreparedStatement deletePreguntaStatement = connection.prepareStatement(deletePreguntaQuery);
            deletePreguntaStatement.setInt(1, idPregunta);

            int rowsAffected = deletePreguntaStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Pregunta getPreguntaById(int idPregunta) {
        try {
            String query = "SELECT id_pregunta, pregunta, tipo_pregunta_id_tipo_pregunta FROM pregunta WHERE id_pregunta = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idPregunta);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id_pregunta");
                String preguntaText = resultSet.getString("pregunta");
                int tipoPreguntaId = resultSet.getInt("tipo_pregunta_id_tipo_pregunta");
                /*return new Pregunta(id, preguntaText, tipoPreguntaId);*//*
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pregunta> getAllPreguntas() {
        List<Pregunta> preguntas = new ArrayList<>();
        try {
            String query = "SELECT id_pregunta, pregunta, tipo_pregunta_id_tipo_pregunta FROM pregunta";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                int id_pregunta = resultSet.getInt("id_pregunta");
                String pregunta = resultSet.getString("pregunta");
                int tipo_pregunta_id_tipo_pregunta = resultSet.getInt("tipo_pregunta_id_tipo_pregunta");
                /*Pregunta p = new Pregunta(id_pregunta, pregunta, tipo_pregunta_id_tipo_pregunta);
                preguntas.add(p);*//*
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preguntas;
    }

    // Método adicional para obtener las preguntas de un examen específico
    public List<Pregunta> getPreguntasByExamenId(int examenId) {
        List<Pregunta> preguntas = new ArrayList<>();
        try {
            String query = "SELECT p.id_pregunta, p.pregunta, p.tipo_pregunta_id_tipo_pregunta " +
                    "FROM pregunta p " +
                    "JOIN examen_tiene_pregunta etp ON p.id_pregunta = etp.pregunta_id_pregunta " +
                    "WHERE etp.examen_id_examen = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, examenId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int id_pregunta = resultSet.getInt("id_pregunta");
                String pregunta = resultSet.getString("pregunta");
                int tipo_pregunta_id_tipo_pregunta = resultSet.getInt("tipo_pregunta_id_tipo_pregunta");
                /*Pregunta p = new Pregunta(id_pregunta, pregunta, tipo_pregunta_id_tipo_pregunta);
                preguntas.add(p);*//*
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preguntas;
    }*/

}