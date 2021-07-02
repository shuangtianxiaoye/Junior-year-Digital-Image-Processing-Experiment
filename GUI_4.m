function varargout = GUI_4(varargin)
% GUI_4 MATLAB code for GUI_4.fig
%      GUI_4, by itself, creates a new GUI_4 or raises the existing
%      singleton*.
%
%      H = GUI_4 returns the handle to a new GUI_4 or the handle to
%      the existing singleton*.
%
%      GUI_4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_4.M with the given input arguments.
%
%      GUI_4('Property','Value',...) creates a new GUI_4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_4

% Last Modified by GUIDE v2.5 01-Jun-2021 14:57:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_4_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_4 is made visible.
function GUI_4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_4 (see VARARGIN)

% Choose default command line output for GUI_4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = im2double(imread('houghorg.bmp'));%rgb2gray();
I_Gnoise = im2double(imread('houghgau.bmp'));%rgb2gray()
I_Snoise = im2double(imread('houghsalt.bmp'));%rgb2gray();%

% I_Gnoise = imnoise(I,'gaussian',1e-3);
% I_Snoise = imnoise(I,'salt & pepper',1e-3);

% [M_G,N_G] = size(I_Gnoise);
% [M_S,N_S] = size(I_Snoise);

% figure;
subplot(1,3,1);
imshow(I);
title('原图');%original
subplot(1,3,2);
imshow(I_Gnoise);
title('高斯噪声');%gaussian noised
subplot(1,3,3);
imshow(I_Snoise);
title('椒盐噪声');%salt & pepper noised

% --------------------------------------------------------------------
function gauss_Callback(hObject, eventdata, handles)
% hObject    handle to gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saltpepper_Callback(hObject, eventdata, handles)
% hObject    handle to saltpepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function exit4_Callback(hObject, eventdata, handles)
% hObject    handle to exit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();

% --------------------------------------------------------------------
function saltpepper_Robert_Callback(hObject, eventdata, handles)
% hObject    handle to saltpepper_Robert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%椒盐噪声Robert边缘检测&Hough重建
I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghsalt.bmp'));  %读取含椒盐噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

IRoberts = edge(I_smooth,'Roberts');  %Robert算子边缘检测

[par1,par3]=Hough(IRoberts);  %Hough变换

subplot(2,2,1);
imshow(I);
title('原图');

subplot(2,2,2);
imshow(I_noise);
title('椒盐噪声');

subplot(2,2,3);
imshow(IRoberts);
title('Robert边缘检测算子');

subplot(2,2,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function saltpepper_Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to saltpepper_Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%椒盐噪声Sobel边缘检测&Hough重建
I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghsalt.bmp'));  %读取含椒盐噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

ISobel = edge(I_smooth,'Sobel');  %Sobel算子边缘检测

[par1,par3]=Hough(ISobel);  %Hough变换

subplot(2,2,1);
imshow(I);
title('原图');

subplot(2,2,2);
imshow(I_noise);
title('椒盐噪声');

subplot(2,2,3);
imshow(ISobel);
title('Sobel边缘检测算子');

subplot(2,2,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function saltpepper_Laplacian_Callback(hObject, eventdata, handles)
% hObject    handle to saltpepper_Laplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%椒盐噪声Laplacian边缘检测&Hough重建
I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghsalt.bmp'));  %读取含椒盐噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

ILap = edge(I_smooth,'log');  %Laplacian算子边缘检测

[par1,par3]=Hough(ILap);  %Hough变换

subplot(2,2,1);
imshow(I);
title('原图');

subplot(2,2,2);
imshow(I_noise);
title('椒盐噪声');

subplot(2,2,3);
imshow(ILap);
title('Laplacian边缘检测算子');

subplot(2,2,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function saltpepper_All_Callback(hObject, eventdata, handles)
% hObject    handle to saltpepper_All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%椒盐噪声边缘检测&Hough重建比较
% I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghsalt.bmp'));  %读取含椒盐噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

IRoberts = edge(I_smooth,'Roberts');  %Robert算子边缘检测

[par1,par3]=Hough(IRoberts);  %Hough变换

subplot(2,3,1);
imshow(IRoberts);
title('Robert边缘检测算子');

subplot(2,3,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

ISobel = edge(I_smooth,'Sobel');  %Sobel算子边缘检测

[par1,par3]=Hough(ISobel);  %Hough变换

subplot(2,3,2);
imshow(ISobel);
title('Sobel边缘检测算子');

subplot(2,3,5);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

ILap = edge(I_smooth,'log');  %Laplacian算子边缘检测

[par1,par3]=Hough(ILap);  %Hough变换

subplot(2,3,3);
imshow(ILap);
title('Laplacian边缘检测算子');

subplot(2,3,6);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function gauss_Robert_Callback(hObject, eventdata, handles)
% hObject    handle to gauss_Robert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%高斯噪声Robert边缘检测&Hough重建
I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghgau.bmp'));  %读取含高斯噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

IRoberts = edge(I_smooth,'Roberts');  %Robert算子边缘检测

[par1,par3]=Hough(IRoberts);  %Hough变换

subplot(2,2,1);
imshow(I);
title('原图');

subplot(2,2,2);
imshow(I_noise);
title('高斯噪声');

subplot(2,2,3);
imshow(IRoberts);
title('Robert边缘检测算子');

subplot(2,2,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function gauss_Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to gauss_Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%高斯噪声Sobel边缘检测&Hough重建
I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghgau.bmp'));  %读取含高斯噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

ISobel = edge(I_smooth,'Sobel');  %Sobel算子边缘检测

[par1,par3]=Hough(ISobel);  %Hough变换

subplot(2,2,1);
imshow(I);
title('原图');

subplot(2,2,2);
imshow(I_noise);
title('高斯噪声');

subplot(2,2,3);
imshow(ISobel);
title('Sobel边缘检测算子');

subplot(2,2,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function gauss_Laplacian_Callback(hObject, eventdata, handles)
% hObject    handle to gauss_Laplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%高斯噪声Laplacian边缘检测&Hough重建
I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghgau.bmp'));  %读取含高斯噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

ILap = edge(I_smooth,'log');  %Laplacian算子边缘检测

[par1,par3]=Hough(ILap);  %Hough变换

subplot(2,2,1);
imshow(I);
title('原图');

subplot(2,2,2);
imshow(I_noise);
title('高斯噪声');

subplot(2,2,3);
imshow(ILap);
title('Laplacian边缘检测算子');

subplot(2,2,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

% --------------------------------------------------------------------
function gauss_All_Callback(hObject, eventdata, handles)
% hObject    handle to gauss_All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%高斯噪声边缘检测&Hough重建比较
% I = im2double(imread('houghorg.bmp'));  %读取原图
I_noise = im2double(imread('houghgau.bmp'));  %读取含高斯噪声图片
% [height,width] = size(I_noise);
m = 7;
I_smooth = medfilt2(I_noise,[m m]);  %以7*7掩膜模板进行中值滤波

IRoberts = edge(I_smooth,'Roberts');  %Robert算子边缘检测

[par1,par3]=Hough(IRoberts);  %Hough变换

subplot(2,3,1);
imshow(IRoberts);
title('Robert边缘检测算子');

subplot(2,3,4);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

ISobel = edge(I_smooth,'Sobel');  %Sobel算子边缘检测

[par1,par3]=Hough(ISobel);  %Hough变换

subplot(2,3,2);
imshow(ISobel);
title('Sobel边缘检测算子');

subplot(2,3,5);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

ILap = edge(I_smooth,'log');  %Laplacian算子边缘检测

[par1,par3]=Hough(ILap);  %Hough变换

subplot(2,3,3);
imshow(ILap);
title('Laplacian边缘检测算子');

subplot(2,3,6);
imshow(I_noise);
viscircles(par1,par3);  %将重建图像叠加到加噪图像上
title('Hough重建');

%Hough变换进行参数提取
function [ par1, par3 ] = Hough( BW )  
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

r_max=100;
r_min=40;
step_r=1;
step_angle=pi/20;
p=0.5;
[m,n] = size(BW);
size_r = round((r_max-r_min)/step_r)+1;  %((100-40)/1)+1=61
size_angle = round(2*pi/step_angle);  %(2pi/(pi/20))=40
hough_space = zeros(m,n,size_r);  %Hough变换域：创建一个3维m*n*61的零矩阵空间
[rows,cols] = find(BW);  %找到图片中非零元素，行存在rows,列存在cols
ecount = size(rows);  %非零元素个数
% Hough变换
% 将图像空间(x,y)对应到参数空间(a,b,r) 即每一个(x,y)对应于三维空间的一个圆锥
% a = x-r*cos(angle)
% b = y-r*sin(angle)
for i=1:ecount
    for r=1:size_r
        for k=1:size_angle
            a = round(rows(i)-(r_min+(r-1)*step_r)*cos(k*step_angle));
            b = round(cols(i)-(r_min+(r-1)*step_r)*sin(k*step_angle));
            if(a>0 && a<=m && b>0 && b<=n)
                hough_space(a,b,r) = hough_space(a,b,r)+1;
            end
        end
    end
end
% 搜索超过阈值的聚集点
max_para = max(max(max(hough_space)));  %找到所有圆锥相交最大的点
index = find(hough_space>=max_para*p);
length = size(index);
hough_circle = false(m,n);  %创建m*n矩阵，所有元素为0，逻辑假
for i=1:ecount
    for k=1:length
        par3 = floor(index(k)/(m*n))+1;
        par2 = floor((index(k)-(par3-1)*(m*n))/m)+1;
        par1 = index(k)-(par3-1)*(m*n)-(par2-1)*m;
        if((rows(i)-par1)^2+(cols(i)-par2)^2<(r_min+(par3-1)*step_r)^2+5 &&...
                (rows(i)-par1)^2+(cols(i)-par2)^2>(r_min+(par3-1)*step_r)^2-5)
            hough_circle(rows(i),cols(i)) = true;
        end
    end
end

% 打印检测结果
for k=1:length
    par3 = floor(index(k)/(m*n))+1;
    par2 = floor((index(k)-(par3-1)*(m*n))/m)+1;
    par1 = index(k)-(par3-1)*(m*n)-(par2-1)*m;
    par3 = r_min+(par3-1)*step_r;
   % fprintf(1,'Center %d %d radius %d\n',par1,par2,par3);
   % para(:,k) = [par1,par2,par3];
end

% viscircles([par2 par1],par3);
par1=[par2 par1];
