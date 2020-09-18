from django.db import models

# Create your models here.
class Project(models.Model):
    title = models.CharField(max_length=200, verbose_name="Titulo")
    description = models.TextField(verbose_name="Descripcion")
    image = models.ImageField(verbose_name="Imagen",upload_to="projects")
    link = models.URLField(null=True, blank=True, verbose_name="Enlace Web")
    created = models.DateTimeField(auto_now_add=True, verbose_name="Fecha de Creacion") #auto_now_add se ejecuta cuando se crea la 1ra vez
    updated = models.DateTimeField(auto_now=True, verbose_name="Fecha de Edicion") #auto_now se ejecuta cuando hay un cambio

    class Meta:
        verbose_name = "Proyecto"
        verbose_name_plural = "Proyectos"
        ordering = ["-created"] # "created" ordena de mas viejo a mas nuevo
                               # "-created" ordena de mas nuevo a mas viejo
    def __str__(self):
        return self.title # aqui hago referencia al title de la class Project
                          # Para que me muestre el nombre que yo le di en ves de Project project(1)