package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CarreraDao {
    public ArrayList<Carrera> getAll(){
        ArrayList<Carrera> lista = new ArrayList<>();
        String query = "select * from Carrera";
        try {
            Connection con = DatabaseConnectionManager.getConnection(); //conección a la base
            PreparedStatement ps = con.prepareStatement(query); //preparar la base de datos
            ResultSet rs = ps.executeQuery(); //ejecutar
            while (rs.next()) { //lo ejecuta por cada ususario en la base de datos
                Carrera carrera = new Carrera();
                carrera.setId_carrera(rs.getInt("id_carrera"));
                carrera.setCarrera(rs.getString("nombre_carrera"));
                carrera.setId_division_academica(rs.getInt("division_academica_id_division_academica"));
                lista.add(carrera);
            }
        }catch (SQLException e){
        }
        return lista;
    }
}
