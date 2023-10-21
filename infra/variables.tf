variable region {
    type        = string
    default     = ""
    description = "aws region"
}

variable vpc_tag {
    type        = string
    default     = ""
    description = "aws tag name for vpc"
}

variable vpc_cidr {
    type        = string
    default     = ""
    description = "aws vpc cidr block"
}

variable subnet_tag {
    type        = string
    default     = ""
    description = "aws tag name for subnet"
}

variable subnet_cidr_1 {
    type        = string
    default     = ""
    description = "aws subnet cidr block"
}

variable subnet_cidr_2 {
    type        = string
    default     = ""
    description = "aws subnet cidr block"
}

variable subnet_az_1 {
    type        = string
    default     = ""
    description = "aws subnet availability zone"
}

variable subnet_az_2 {
    type        = string
    default     = ""
    description = "aws subnet availability zone"
}

variable eks_name {
    type        = string
    default     = ""
    description = "eks cluster name"
}

variable eks_version {
    type        = string
    default     = ""
    description = "aws eks version"
}

variable eks_tag {
    type        = string
    default     = ""
    description = "aws tag name for eks cluster"
}

variable iam_role_name {
    type        = string
    default     = ""
    description = "eks cluster IAM role name"
}