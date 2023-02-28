variable "bucket_name_data" {
  description = "zoomcamp data"
  type        = string
  default     = "zoomcamp-data-tf3bucket"
}

variable "bucket_name_dag" {
  description = "zoomcamp dags"
  type        = string
  default     = "zoomcamp-airflowdags-tf3bucket"
}

