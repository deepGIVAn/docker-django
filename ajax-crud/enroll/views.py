from django.shortcuts import render
from .forms import StudentRegistration
from .models import User
from django.http import JsonResponse

def home(request):
    form = StudentRegistration()
    student = User.objects.all()
    return render(request, 'enroll/home.html', {'form':form,'student':student})

def save_data(request):
    if request.method == "POST":
        form = StudentRegistration(request.POST)
        # name = form.cleaned_data['name']
        name = request.POST.get('name')
        email = request.POST.get('email')
        password = request.POST.get('password')
        sid = request.POST.get('sid')
        if form.is_valid() and sid == "":
            reg = User(name=name,email=email,password=password)
        elif sid != "":
            User.objects.get(id=sid).delete()
            reg = User(id=sid,name=name,email=email,password=password)
        else:
            return JsonResponse({'status':False})
        reg.save()
        student = User.objects.values()
        student_list = list(student)
        return JsonResponse({'status':True,'student_list':student_list})
    else:
        return JsonResponse({'status':False})

def delete_data(request):
    if request.method == "POST":
        id = request.POST.get('sid')
        pi = User.objects.get(pk=id)
        pi.delete()
        return JsonResponse({'status':True})
    else:
        return JsonResponse({'status':False})
    
def edit_data(request):
    if request.method == "POST":
        id = request.POST.get('sid')
        student = User.objects.get(pk=id)
        student_data = {"id": student.id,"name":student.name,"email":student.email,"password":student.password}
        return JsonResponse(student_data)
    else:
        return JsonResponse({'status':False})