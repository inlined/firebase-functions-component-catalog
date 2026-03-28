variable "projectId" {
  description = "The project ID."
  type        = string
  default     = "inlined-junkdrawer"
}

variable "databaseURL" {
  description = "The database URL."
  type        = string
  default     = "https://inlined-junkdrawer.firebaseio.com"
}

variable "storageBucket" {
  description = "The storage bucket."
  type        = string
  default     = "inlined-junkdrawer.appspot.com"
}

variable "location" {
  description = "The location."
  type        = string
  default     = "us-central1"
}
