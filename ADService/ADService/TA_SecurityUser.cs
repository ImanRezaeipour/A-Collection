//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ADService
{
    using System;
    using System.Collections.Generic;
    
    public partial class TA_SecurityUser
    {
        public decimal user_ID { get; set; }
        public Nullable<decimal> user_PersonID { get; set; }
        public Nullable<decimal> user_RoleID { get; set; }
        public Nullable<decimal> user_DomainID { get; set; }
        public string user_UserName { get; set; }
        public string user_Password { get; set; }
        public bool user_Active { get; set; }
        public Nullable<System.DateTime> user_LastActivityDate { get; set; }
        public bool user_IsADAuthenticateActive { get; set; }
    
        public virtual TA_Person TA_Person { get; set; }
    }
}