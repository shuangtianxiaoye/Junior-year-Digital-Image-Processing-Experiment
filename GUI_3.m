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
title('ԭͼ');
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
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%�ȿ��ٱ�����
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %�ȿ�����
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %�ٱ�����
    Idilate2 = imdilate(Idilate,SE);  %�ȶ�ֵ����
    Ierode2 = imerode(Idilate2,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,3,2);
    imshow(Idilate);
    title(['�ȿ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['�ٱ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_3_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%�ȿ��ٱ�����
r = [1,3,5,7];  %Բ�뾶ֵ

for k=2
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %�ȿ�����
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %�ٱ�����
    Idilate2 = imdilate(Idilate,SE);  %�ȶ�ֵ����
    Ierode2 = imerode(Idilate2,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,3,2);
    imshow(Idilate);
    title(['�ȿ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['�ٱ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_5_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%�ȿ��ٱ�����
r = [1,3,5,7];  %Բ�뾶ֵ

for k=3
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %�ȿ�����
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %�ٱ�����
    Idilate2 = imdilate(Idilate,SE);  %�ȶ�ֵ����
    Ierode2 = imerode(Idilate2,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,3,2);
    imshow(Idilate);
    title(['�ȿ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['�ٱ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_7_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%�ȿ��ٱ�����
r = [1,3,5,7];  %Բ�뾶ֵ

for k=4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %�ȿ�����
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %�ٱ�����
    Idilate2 = imdilate(Idilate,SE);  %�ȶ�ֵ����
    Ierode2 = imerode(Idilate2,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,3,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,3,2);
    imshow(Idilate);
    title(['�ȿ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    subplot(1,3,3);
    imshow(Ierode2);
    title(['�ٱ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function open_close_all_Callback(hObject, eventdata, handles)
% hObject    handle to open_close_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%�ȿ��ٱ�����
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1:4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %�ȿ�����
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %�ٱ�����
    Idilate2 = imdilate(Idilate,SE);  %�ȶ�ֵ����
    Ierode2 = imerode(Idilate2,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(3,4,k);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(3,4,k+4);
    imshow(Idilate);
    title(['�ȿ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    subplot(3,4,k+8);
    imshow(Ierode2);
    title(['�ٱ�����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_1_Callback(hObject, eventdata, handles)
% hObject    handle to closing_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Idilate = imdilate(Igray,SE);  %�ȶ�ֵ����
    Ierode = imerode(Idilate,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_3_Callback(hObject, eventdata, handles)
% hObject    handle to closing_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=2
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Idilate = imdilate(Igray,SE);  %�ȶ�ֵ����
    Ierode = imerode(Idilate,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_5_Callback(hObject, eventdata, handles)
% hObject    handle to closing_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=3
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Idilate = imdilate(Igray,SE);  %�ȶ�ֵ����
    Ierode = imerode(Idilate,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_7_Callback(hObject, eventdata, handles)
% hObject    handle to closing_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Idilate = imdilate(Igray,SE);  %�ȶ�ֵ����
    Ierode = imerode(Idilate,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function closing_all_Callback(hObject, eventdata, handles)
% hObject    handle to closing_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1:4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Idilate = imdilate(Igray,SE);  %�ȶ�ֵ����
    Ierode = imerode(Idilate,SE);  %�ٶ�ֵ��ʴ
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(2,4,k+4);
    imshow(Ierode);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_1_Callback(hObject, eventdata, handles)
% hObject    handle to opening_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_3_Callback(hObject, eventdata, handles)
% hObject    handle to opening_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=2
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_5_Callback(hObject, eventdata, handles)
% hObject    handle to opening_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=3
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_7_Callback(hObject, eventdata, handles)
% hObject    handle to opening_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function opening_all_Callback(hObject, eventdata, handles)
% hObject    handle to opening_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1:4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Ierode,SE);  %�ٶ�ֵ����
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('������ǰͼ��');
    subplot(2,4,k+4);
    imshow(Idilate);
    title(['�������ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function midfilter_2_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����

A = [2,3,4,5];  %��ֵ�˲����������Χ
k = 1;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('ԭʼͼ��');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['��ֵ�˲��������: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('��䷽����ֵ�ָ�ͼ��');

% --------------------------------------------------------------------
function midfilter_3_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����

A = [2,3,4,5];  %��ֵ�˲����������Χ
k = 2;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('ԭʼͼ��');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['��ֵ�˲��������: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('��䷽����ֵ�ָ�ͼ��');

% --------------------------------------------------------------------
function midfilter_4_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����

A = [2,3,4,5];  %��ֵ�˲����������Χ
k = 3;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('ԭʼͼ��');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['��ֵ�˲��������: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('��䷽����ֵ�ָ�ͼ��');

% --------------------------------------------------------------------
function midfilter_5_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����

A = [2,3,4,5];  %��ֵ�˲����������Χ
k = 4;
m = A(k);
Ismooth=medfilt2(I,[m,m]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��
%figure();
%subplot(3,4,k),imshow(I); 
subplot(1,3,1),imshow(I); 
title('ԭʼͼ��');
%subplot(3,4,k+4),imshow(Ismooth); 
subplot(1,3,2),imshow(Ismooth); 
title(['��ֵ�˲��������: ', num2str(m),'*',num2str(m)]); 
%subplot(3,4,k+8),imshow(Igray); 
subplot(1,3,3),imshow(Igray); 
title('��䷽����ֵ�ָ�ͼ��');

% --------------------------------------------------------------------
function midfilter_all_Callback(hObject, eventdata, handles)
% hObject    handle to midfilter_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����

A = [2,3,4,5];  %��ֵ�˲����������Χ
for k=1:4
    m = A(k);
   Ismooth=medfilt2(I,[m,m]);  %��m*m��С���������ֵ�˲�
   threshold = graythresh(Ismooth);  %�����䷽������ֵ
   Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��
   %figure();
   subplot(3,4,k),imshow(I); 
   %subplot(1,3,1),imshow(I); 
   title('ԭʼͼ��');
   subplot(3,4,k+4),imshow(Ismooth); 
   %subplot(1,3,2),imshow(Ismooth); 
   title(['��ֵ�˲��������: ', num2str(m),'*',num2str(m)]); 
   subplot(3,4,k+8),imshow(Igray); 
   %subplot(1,3,3),imshow(Igray); 
   title('��䷽����ֵ�ָ�ͼ��');
end  %ͨ�������Ƚ����ǿ��Կ���ȡ�뾶Ϊ5��ʱ��Ч������


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
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_3_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=2
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_5_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=3
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_7_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Idilate);
    title(['����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function dilate_all_Callback(hObject, eventdata, handles)
% hObject    handle to dilate_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1:4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    %Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(2,4,k+4);
    imshow(Idilate);
    title(['����ͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_1_Callback(hObject, eventdata, handles)
% hObject    handle to erode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    %Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['��ʴͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_3_Callback(hObject, eventdata, handles)
% hObject    handle to erode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=2
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    %Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['��ʴͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_5_Callback(hObject, eventdata, handles)
% hObject    handle to erode_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=3
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    %Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['��ʴͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_7_Callback(hObject, eventdata, handles)
% hObject    handle to erode_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
%[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    %Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(1,2,1);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(1,2,2);
    imshow(Ierode);
    title(['��ʴͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end

% --------------------------------------------------------------------
function erode_all_Callback(hObject, eventdata, handles)
% hObject    handle to erode_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=rgb2gray(imread('shiyan3.bmp'));  %��ͼƬ
[M,N] = size(I);  %ͼƬ����


%��ֵ�˲�&��䷽����ֵ�ָ�
Ismooth=medfilt2(I,[5,5]);  %��m*m��С���������ֵ�˲�
threshold = graythresh(Ismooth);  %�����䷽������ֵ
Igray = imbinarize(Ismooth,threshold);  %��1(��ɫ)/2(��ɫ)�滻����ͼ�������ȴ���/С����ֵ������Ԫ��


%������
r = [1,3,5,7];  %Բ�뾶ֵ

for k=1:4
    
    SE = strel('disk',r(k));  %����һ���뾶Ϊr��Բ�νṹԪ��
    Ierode = imerode(Igray,SE);  %�ȶ�ֵ��ʴ
    %Idilate = imdilate(Igray,SE);  %�ٶ�ֵ����
    %figure();
    subplot(2,4,k);
    imshow(Igray);
    title('����ǰͼ��');
    subplot(2,4,k+4);
    imshow(Ierode);
    title(['��ʴͼ�� Բ�뾶Ϊ��',num2str(r(k))]);
    
end
