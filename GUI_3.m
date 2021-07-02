function varargout = GUI_3(varargin)
% GUI_3 MATLAB code for GUI_3.fig
%      GUI_3, by itself, creates a new GUI_3 or raises the existing
%      singleton*.
%
%      H = GUI_3 returns the handle to a new GUI_3 or the handle to
%      the existing singleton*.
%
%      GUI_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_3.M with the given input arguments.
%
%      GUI_3('Property','Value',...) creates a new GUI_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_3

% Last Modified by GUIDE v2.5 02-Jun-2021 20:44:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_3_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_3_OutputFcn, ...
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


% --- Executes just before GUI_3 is made visible.
function GUI_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_3 (see VARARGIN)

% Choose default command line output for GUI_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
figure=imread('shiyan3.bmp'); 
subplot(1,3,2);
imshow(figure);
title('原图');
% UIWAIT makes GUI_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function midfilter_OSTU_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_OSTU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function opening_Callback(hObject, eventdata, handles)
% hObject    handle to opening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function closing_Callback(hObject, eventdata, handles)
% hObject    handle to closing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_close_Callback(hObject, eventdata, handles)
% hObject    handle to open_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function exit3_Callback(hObject, eventdata, handles)
% hObject    handle to exit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();

% --------------------------------------------------------------------
function open_close_1_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%先开再闭运算
r = [1,3,5,7];  %圆半径值

for k=1
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %先开运算
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %再闭运算
    Idilate2 = imdilate(Idilate,SE);  %先二值膨胀
    Ierode2 = imerode(Idilate2,SE);  %再二值腐蚀
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,3,2);
    imshow(Idilate);
    title(['先开运算图像 圆半径为：',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['再闭运算图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_3_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%先开再闭运算
r = [1,3,5,7];  %圆半径值

for k=2
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %先开运算
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %再闭运算
    Idilate2 = imdilate(Idilate,SE);  %先二值膨胀
    Ierode2 = imerode(Idilate2,SE);  %再二值腐蚀
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,3,2);
    imshow(Idilate);
    title(['先开运算图像 圆半径为：',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['再闭运算图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_5_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%先开再闭运算
r = [1,3,5,7];  %圆半径值

for k=3
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %先开运算
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %再闭运算
    Idilate2 = imdilate(Idilate,SE);  %先二值膨胀
    Ierode2 = imerode(Idilate2,SE);  %再二值腐蚀
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,3,2);
    imshow(Idilate);
    title(['先开运算图像 圆半径为：',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['再闭运算图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_7_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%先开再闭运算
r = [1,3,5,7];  %圆半径值

for k=4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %先开运算
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %再闭运算
    Idilate2 = imdilate(Idilate,SE);  %先二值膨胀
    Ierode2 = imerode(Idilate2,SE);  %再二值腐蚀
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,3,2);
    imshow(Idilate);
    title(['先开运算图像 圆半径为：',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['再闭运算图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_all_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%先开再闭运算
r = [1,3,5,7];  %圆半径值

for k=1:4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %先开运算
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %再闭运算
    Idilate2 = imdilate(Idilate,SE);  %先二值膨胀
    Ierode2 = imerode(Idilate2,SE);  %再二值腐蚀
    %figure();
    subplot(3,4,k);
    imshow(Igray);
    title('运算前图像');
    subplot(3,4,k+4);
    imshow(Idilate);
    title(['先开运算图像 圆半径为：',num2str(r(k))]);
    subplot(3,4,k+8);
    imshow(Ierode2);
    title(['再闭运算图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_1_Callback(hObject, eventdata, handles)
% hObject    handle to closing_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%闭运算
r = [1,3,5,7];  %圆半径值

for k=1
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Idilate = imdilate(Igray,SE);  %先二值膨胀
    Ierode = imerode(Idilate,SE);  %再二值腐蚀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('闭运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['闭运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_3_Callback(hObject, eventdata, handles)
% hObject    handle to closing_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%闭运算
r = [1,3,5,7];  %圆半径值

for k=2
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Idilate = imdilate(Igray,SE);  %先二值膨胀
    Ierode = imerode(Idilate,SE);  %再二值腐蚀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('闭运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['闭运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_5_Callback(hObject, eventdata, handles)
% hObject    handle to closing_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%闭运算
r = [1,3,5,7];  %圆半径值

for k=3
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Idilate = imdilate(Igray,SE);  %先二值膨胀
    Ierode = imerode(Idilate,SE);  %再二值腐蚀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('闭运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['闭运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_7_Callback(hObject, eventdata, handles)
% hObject    handle to closing_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%闭运算
r = [1,3,5,7];  %圆半径值

for k=4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Idilate = imdilate(Igray,SE);  %先二值膨胀
    Ierode = imerode(Idilate,SE);  %再二值腐蚀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('闭运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['闭运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_all_Callback(hObject, eventdata, handles)
% hObject    handle to closing_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%闭运算
r = [1,3,5,7];  %圆半径值

for k=1:4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Idilate = imdilate(Igray,SE);  %先二值膨胀
    Ierode = imerode(Idilate,SE);  %再二值腐蚀
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('闭运算前图像');
    subplot(2,4,k+4);
    imshow(Ierode);
    title(['闭运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_1_Callback(hObject, eventdata, handles)
% hObject    handle to opening_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=1
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('开运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['开运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_3_Callback(hObject, eventdata, handles)
% hObject    handle to opening_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=2
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('开运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['开运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_5_Callback(hObject, eventdata, handles)
% hObject    handle to opening_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=3
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('开运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['开运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_7_Callback(hObject, eventdata, handles)
% hObject    handle to opening_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('开运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['开运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_all_Callback(hObject, eventdata, handles)
% hObject    handle to opening_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=1:4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Ierode,SE);  %再二值膨胀
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('开运算前图像');
    subplot(2,4,k+4);
    imshow(Idilate);
    title(['开运算后图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function midfilter_2_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽

A = [2,3,4,5];  %中值滤波滑块面积范围
k = 1;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('原始图像');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['中值滤波滑块面积: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('类间方差阈值分割图像');

% --------------------------------------------------------------------
function midfilter_3_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽

A = [2,3,4,5];  %中值滤波滑块面积范围
k = 2;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('原始图像');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['中值滤波滑块面积: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('类间方差阈值分割图像');

% --------------------------------------------------------------------
function midfilter_4_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽

A = [2,3,4,5];  %中值滤波滑块面积范围
k = 3;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('原始图像');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['中值滤波滑块面积: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('类间方差阈值分割图像');

% --------------------------------------------------------------------
function midfilter_5_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽

A = [2,3,4,5];  %中值滤波滑块面积范围
k = 4;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('原始图像');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['中值滤波滑块面积: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('类间方差阈值分割图像');

% --------------------------------------------------------------------
function midfilter_all_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽

A = [2,3,4,5];  %中值滤波滑块面积范围
for k=1:4
    m = A(k);
   Ismooth=medfilt2(I,[m,m]);  %以m*m大小的领域块中值滤波
   threshold = graythresh(Ismooth);  %最大类间方差获得阈值
   Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素
   %figure();
   subplot(3,4,k),imshow(I); 
   %subplot(1,3,1),imshow(I); 
   title('原始图像');
   subplot(3,4,k+4),imshow(Ismooth); 
   %subplot(1,3,2),imshow(Ismooth); 
   title(['中值滤波滑块面积: ', num2str(m),'*',num2str(m)]); 
   subplot(3,4,k+8),imshow(Igray); 
   %subplot(1,3,3),imshow(Igray); 
   title('类间方差阈值分割图像');
end  %通过上述比较我们可以看到取半径为5的时候效果更好


% --------------------------------------------------------------------
function erode_Callback(hObject, eventdata, handles)
% hObject    handle to erode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dilate_Callback(hObject, eventdata, handles)
% hObject    handle to dilate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dilate_1_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=1
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['膨胀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_3_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=2
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['膨胀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_5_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=3
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['膨胀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_7_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Idilate);
    title(['膨胀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_all_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=1:4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    %Ierode = imerode(Igray,SE);  %先二值腐蚀
    Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('运算前图像');
    subplot(2,4,k+4);
    imshow(Idilate);
    title(['膨胀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_1_Callback(hObject, eventdata, handles)
% hObject    handle to erode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=1
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    %Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['腐蚀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_3_Callback(hObject, eventdata, handles)
% hObject    handle to erode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=2
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    %Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['腐蚀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_5_Callback(hObject, eventdata, handles)
% hObject    handle to erode_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=3
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    %Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['腐蚀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_7_Callback(hObject, eventdata, handles)
% hObject    handle to erode_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
%[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    %Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('运算前图像');
    subplot(1,2,2);
    imshow(Ierode);
    title(['腐蚀图像 圆半径为：',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_all_Callback(hObject, eventdata, handles)
% hObject    handle to erode_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %读图片
[M,N] = size(I);  %图片长宽


%中值滤波&类间方差阈值分割
Ismooth=medfilt2(I,[5,5]);  %以m*m大小的领域块中值滤波
threshold = graythresh(Ismooth);  %最大类间方差获得阈值
Igray = imbinarize(Ismooth,threshold);  %用1(白色)/2(黑色)替换输入图像中亮度大于/小于阈值的所有元素


%开运算
r = [1,3,5,7];  %圆半径值

for k=1:4
    
    SE = strel('disk',r(k));  %创建一个半径为r的圆形结构元素
    Ierode = imerode(Igray,SE);  %先二值腐蚀
    %Idilate = imdilate(Igray,SE);  %再二值膨胀
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('运算前图像');
    subplot(2,4,k+4);
    imshow(Ierode);
    title(['腐蚀图像 圆半径为：',num2str(r(k))]);
    
end
