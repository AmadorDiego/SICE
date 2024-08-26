package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.DivisionAcademica;
import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.model.Grupo;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
//se agrego Dao para division
public class DivisionAcademicaDao {

    public ArrayList<DivisionAcademica> getAll() {
        ArrayList<DivisionAcademica> lista = new ArrayList<>();
        try (Connection con = DatabaseConnectionManager.getConnection()) {
            String query = "SELECT * FROM division_academica";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DivisionAcademica division = new DivisionAcademica();
                division.setId_division_academica(rs.getInt("id_division_academica"));
                division.setDivision_academica(rs.getString("nombre_division_academica"));
                lista.add(division);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public DivisionAcademica getDivisionCarrera (int id_carrera){
        DivisionAcademica divisionAcademica = new DivisionAcademica();
        String query = "select id_division_academica, nombre_division_academica from division_academica join carrera on id_division_academica = division_academica_id_division_academica where id_carrera = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_carrera);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                divisionAcademica.setId_division_academica(rs.getInt("id_division_academica"));
                divisionAcademica.setDivision_academica(rs.getString("nombre_division_academica"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return divisionAcademica;
    }
}

