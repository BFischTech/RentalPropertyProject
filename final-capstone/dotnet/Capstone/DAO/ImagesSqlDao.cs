using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;

namespace Capstone.DAO
{
    public class ImagesSqlDao : IImagesDao
    {
        private readonly string connectionString;
        public ImagesSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }


        public IList<Images> GetAllImages()
        {
            IList<Images> imgList = new List<Images>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string sql = "SELECT image_id, image_url, description, unit_id " +
                                 "FROM images";
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Images img = new Images();

                        img.imageId = Convert.ToInt32(reader["image_id"]);
                        img.imageUrl = Convert.ToString(reader["image_url"]);
                        img.description = Convert.ToString(reader["description"]);
                        img.unitId = Convert.ToInt32(reader["unit_id"]);

                        imgList.Add(img);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return imgList;
        }
    }
}
