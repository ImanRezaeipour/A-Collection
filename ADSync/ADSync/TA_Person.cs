//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ADSync
{
    using System;
    using System.Collections.Generic;
    
    public partial class TA_Person
    {
        public TA_Person()
        {
            this.TA_SecurityUser = new HashSet<TA_SecurityUser>();
        }
    
        public decimal Prs_ID { get; set; }
        public string Prs_Barcode { get; set; }
        public Nullable<int> Prs__Param { get; set; }
        public Nullable<bool> Prs_Active { get; set; }
        public string Prs_CardNum { get; set; }
        public Nullable<decimal> Prs_DepartmentId { get; set; }
        public string Prs_EmploymentNum { get; set; }
        public Nullable<System.DateTime> Prs_EmploymentDate { get; set; }
        public Nullable<decimal> Prs_ControlStationId { get; set; }
        public Nullable<System.DateTime> Prs_EndEmploymentDate { get; set; }
        public Nullable<decimal> Prs_EmployId { get; set; }
        public Nullable<bool> Prs_Sex { get; set; }
        public string Prs_Education { get; set; }
        public string Prs_FirstName { get; set; }
        public Nullable<int> Prs_MaritalStatus { get; set; }
        public string Prs_LastName { get; set; }
        public Nullable<decimal> Prs_PrsDtlID { get; set; }
        public Nullable<decimal> Prs_UIValidationGroupID { get; set; }
        public Nullable<bool> prs_IsDeleted { get; set; }
    
        public virtual ICollection<TA_SecurityUser> TA_SecurityUser { get; set; }
    }
}
