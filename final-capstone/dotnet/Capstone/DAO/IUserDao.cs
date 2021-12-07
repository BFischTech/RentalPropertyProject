using Capstone.Models;

namespace Capstone.DAO
{
    public interface IUserDao
    {
        Users GetUser(string username);
        Users AddUser(string username, string password, string role);
    }
}
