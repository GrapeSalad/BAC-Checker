using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using BloodAlcoholContent;

namespace BloodAlcoholContent.Objects
{
  public class Bartender
  {
    private string _name;
    private int _id;

    public Bartender(string Name, int Id = 0)
    {
      _id = Id;
      _name = Name;
    }

    public int GetId()
    {
      return _id;
    }
    public string GetName()
    {
      return _name;
    }

    public void SetId(int Id)
    {
      _id = Id;
    }
    public override bool Equals(System.Object otherBartender)
    {
      if (!(otherBartender is Bartender))
      {
        return false;
      }
      else
      {
        Bartender newBartender = (Bartender) otherBartender;
        bool idEquality = this.GetId() == newBartender.GetId();
        bool nameEquality = this.GetName() == newBartender.GetName();
        return (idEquality && nameEquality);
      }
    }
    public static void DeleteAll()
    {
      SqlConnection conn = DB.Connection();
      conn.Open();
      SqlCommand cmd = new SqlCommand("DELETE FROM bartenders;", conn);
      cmd.ExecuteNonQuery();
      conn.Close();
    }

    public static List<Bartender> GetAll()
    {
      List<Bartender> allBartenders = new List<Bartender>{};

      SqlConnection conn = DB.Connection();
      conn.Open();

      SqlCommand cmd = new SqlCommand("SELECT * FROM bartenders ORDER BY name;", conn);
      SqlDataReader rdr = cmd.ExecuteReader();

      while(rdr.Read())
      {
        int bartenderId = rdr.GetInt32(0);
        string bartenderName = rdr.GetString(1);
        Bartender newBartender = new Bartender(bartenderName, bartenderId);
        allBartenders.Add(newBartender);
      }
      if (rdr != null)
      {
        rdr.Close();
      }
      if (conn != null)
      {
        conn.Close();
      }
      return allBartenders;
    }
    public void Save()
    {
      SqlConnection conn = DB.Connection();
      conn.Open();

      SqlCommand cmd = new SqlCommand("INSERT INTO bartenders (name) OUTPUT INSERTED.id VALUES (@BartenderName)", conn);

      SqlParameter nameParam = new SqlParameter();
      nameParam.ParameterName = "@BartenderName";
      nameParam.Value = this.GetName();

      cmd.Parameters.Add(nameParam);

      SqlDataReader rdr = cmd.ExecuteReader();

      while(rdr.Read())
      {
        this._id = rdr.GetInt32(0);
      }
      if (rdr != null)
      {
        rdr.Close();
      }
      if (conn != null)
      {
        conn.Close();
      }
    }
    public static Bartender Find(int id)
    {
      SqlConnection conn = DB.Connection();
      conn.Open();

      SqlCommand cmd = new SqlCommand("SELECT * FROM bartenders WHERE id = @BartenderId", conn);

      SqlParameter bartenderIdParameter = new SqlParameter();
      bartenderIdParameter.ParameterName = "@BartenderId";
      bartenderIdParameter.Value = id.ToString();

      cmd.Parameters.Add(bartenderIdParameter);

      SqlDataReader rdr = cmd.ExecuteReader();

      int foundBartenderId = 0;
      string foundBartenderName = null;

      while(rdr.Read())
      {
        foundBartenderId = rdr.GetInt32(0);
        foundBartenderName = rdr.GetString(1);
      }
      Bartender foundBartender = new Bartender(foundBartenderName, foundBartenderId);

      if (rdr != null)
      {
        rdr.Close();
      }
      if (conn != null)
      {
        conn.Close();
      }
      return foundBartender;
    }
    public void AddPatronToOrdersTable(Patron newPatron)
    {
      SqlConnection conn = DB.Connection();
      conn.Open();
      //NOTE: need to save ID somehow?
      SqlCommand cmd = new SqlCommand("INSERT INTO orders (patrons_id, bartenders_id) OUTPUT INSERTED.patrons_id VALUES (@PatronId, @BartenderId);", conn);
      SqlParameter patronIdParameter = new SqlParameter();
      patronIdParameter.ParameterName = "@PatronId";
      patronIdParameter.Value = newPatron.GetId();
      cmd.Parameters.Add(patronIdParameter);

      // qlParameter drinkIdParameter = new SqlParameter();
      // drinkIdParameter.ParameterName = "@DrinkId";
      // drinkIdParameter.Value = newPatron.GetId();
      // cmd.Parameters.Add(drinkIdParameter);

      SqlParameter bartenderIdParameter = new SqlParameter();
      bartenderIdParameter.ParameterName = "@BartenderId";
      bartenderIdParameter.Value = this.GetId();
      cmd.Parameters.Add(bartenderIdParameter);

      SqlDataReader rdr = cmd.ExecuteReader();
      while (rdr.Read())
      {
        newPatron.SetId(rdr.GetInt32(0));
      }
      if (rdr != null)
      {
        rdr.Close();
      }
      if (conn != null)
      {
        conn.Close();
      }
    }
    public List<Patron> GetPatrons()
    {
      SqlConnection conn = DB.Connection();
      conn.Open();

      SqlCommand cmd = new SqlCommand("SELECT DISTINCT patrons.* FROM bartenders JOIN orders ON (bartenders.id = orders.bartenders_id) JOIN patrons ON (orders.patrons_id = patrons.id) WHERE bartenders.id = @BartenderId;", conn);

      SqlParameter bartenderIdParameter = new SqlParameter();
      bartenderIdParameter.ParameterName = "@BartenderId";
      bartenderIdParameter.Value = this.GetId().ToString();

      cmd.Parameters.Add(bartenderIdParameter);

      SqlDataReader rdr = cmd.ExecuteReader();

      List<Patron> patrons = new List<Patron>{};

      while(rdr.Read())
      {
        int patronId = rdr.GetInt32(0);
        string patronName = rdr.GetString(1);
        string patronGender = rdr.GetString(2);
        decimal patronWeight = rdr.GetInt32(3);
        decimal patronHeight = rdr.GetInt32(4);
        Patron newPatron = new Patron(patronName, patronGender, patronWeight, patronHeight, patronId);
        patrons.Add(newPatron);
      }
      if (rdr != null)
      {
        rdr.Close();
      }
      if (conn != null)
      {
        conn.Close();
      }
      return patrons;
    }
  }
}
