package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CarreraDao {
//se agrego Dao carrera
    public ArrayList<Carrera> getAll() {
        ArrayList<Carrera> lista = new ArrayList<>();
        try (Connection con = DatabaseConnectionManager.getConnection()) {
            String query = "SELECT * FROM carrera";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Carrera carrera = new Carrera();
                carrera.setId_carrera(rs.getInt("id_carrera"));
                carrera.setCarrera(rs.getString("nombre_carrera"));
                carrera.setId_division_academica(rs.getInt("division_academica_id_division_academica"));
                lista.add(carrera);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}
