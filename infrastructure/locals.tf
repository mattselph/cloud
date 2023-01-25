locals {
  instances = {
    vm1 = {
      ip = "1.2.3.4"
    }
  }

  disks = [
    { letter = "D", type = "pd-ssd", size = 80 }
  ]

}
