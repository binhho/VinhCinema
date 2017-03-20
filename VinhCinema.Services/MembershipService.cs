using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Data.Extensions;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;

namespace VinhCinema.Services
{
    public class MembershipService : IMembershipService
    {
        private readonly IEntityBaseRepository<User> _userRepository;
        private readonly IEntityBaseRepository<Role> _roleRepository;
        private readonly IEntityBaseRepository<UserRole> _userRoleRepository;
        private readonly IEncryptionService _encryptionService;
        private readonly IUnitOfWork _unitOfWork;


        public MembershipService(IEntityBaseRepository<User> userRepository, IEntityBaseRepository<Role> roleRepository,
        IEntityBaseRepository<UserRole> userRoleRepository, IEncryptionService encryptionService, IUnitOfWork unitOfWork)
        {
            _userRepository = userRepository;
            _roleRepository = roleRepository;
            _userRoleRepository = userRoleRepository;
            _encryptionService = encryptionService;
            _unitOfWork = unitOfWork;
        }

        public User CreateUser(string username, string email, string password, int[] roles)
        {
            var existingUser = _userRepository.GetSingleByUserName(username);
            if (existingUser != null)
            {
                throw new Exception("User is already in use");
            }

            var passwordSalt = _encryptionService.CreateSalt();
            var user = new User()
            {
                Username = username,
                Email = email,
                Salt = passwordSalt,
                IsLocked = false,
                HashedPassword = _encryptionService.EncryptPassword(password, passwordSalt),
                DateCreated = DateTime.Now
            };
            _userRepository.Add(user);
            _unitOfWork.Commit();
            if (roles != null || roles.Length > 0)
            {
                foreach (var role in roles)
                {
                    addUserToRole(user, role);
                }
            }
            _unitOfWork.Commit();
            return user;
        }

        public User GetUser(int userId)
        {
            var existingUser = _userRepository.GetSingle(userId);
            return existingUser;
        }

        public List<Role> GetUserRoles(string username)
        {
            List<Role> roles = new List<Role>();
            var existingUser = _userRepository.GetSingleByUserName(username);
            if (existingUser != null)
            {
                foreach (var userRole in existingUser.UserRoles)
                {
                    roles.Add(userRole.Role);
                }
            }
            return roles.Distinct().ToList();
        }

        public MembershipContext ValidateUser(string username, string password)
        {
            var memberShip = new MembershipContext();
            var user = _userRepository.GetSingleByUserName(username);

            if (user != null && isUserValid(user, password))
            {
                var userRoles = GetUserRoles(user.Username);
                var test = userRoles.Select(x => x.Name).ToArray();
                memberShip.User = user;
                var identity = new GenericIdentity(user.Username);
                memberShip.Principal = new GenericPrincipal(
                    identity, 
                    userRoles.Select(x => x.Name).ToArray());
            }
            return memberShip;
        }


        private void addUserToRole(User user, int roleID)
        {
            var role = _roleRepository.GetSingle(roleID);
            if (role == null)
            {
                throw new ApplicationException("Role doesn't exist");
            }
            var userRole = new UserRole()
            {
                RoleId = role.ID,
                UserId = user.ID
            };
            _userRoleRepository.Add(userRole);
        }

        private bool isPasswordValid(User user, string password)
        {
            var test1 = _encryptionService.EncryptPassword(password, user.Salt);
            var test2 = user.HashedPassword;
            var test3 = string.Equals(test1, test2);
            return string.Equals(test1, test2);
        }

        private bool isUserValid(User user, string password)
        {
            if (!isPasswordValid(user, password))
            {
                return false;
            }
            return true;
        }
    }
}
