function varargout = GUI_1(varargin)
% GUI_1 MATLAB code for GUI_1.fig
%      GUI_1, by itself, creates a new GUI_1 or raises the existing
%      singleton*.
%
%      H = GUI_1 returns the handle to a new GUI_1 or the handle to
%      the existing singleton*.
%
%      GUI_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_1.M with the given input arguments.
%
%      GUI_1('Property','Value',...) creates a new GUI_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_1

% Last Modified by GUIDE v2.5 20-May-2021 09:49:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_1_OutputFcn, ...
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


% --- Executes just before GUI_1 is made visible.
function GUI_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_1 (see VARARGIN)

% Choose default command line output for GUI_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
set(handles.edit1, 'visible','off'); %����
% set(handles.edit1, 'visible','on'); %��ʾ
set(handles.edit2, 'visible','off'); %����
% set(handles.edit2, 'visible','on'); %��ʾ
set(handles.edit3, 'visible','off'); %����
% set(handles.edit3, 'visible','on'); %��ʾ
figure=imread('Lena512.bmp'); 
subplot(1,3,2);
imshow(figure);
title('Lenaԭͼ 512x512');


% --------------------------------------------------------------------
function transform_Callback(hObject, eventdata, handles)

% % set(handles.edit1, 'visible','off'); %����
% set(handles.edit1, 'visible','on'); %��ʾ
% % set(handles.edit2, 'visible','off'); %����
% set(handles.edit2, 'visible','on'); %��ʾ
% % set(handles.edit3, 'visible','off'); %����
% set(handles.edit3, 'visible','on'); %��ʾ


% --�˳�ѡ��------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
close(gcf);


% --����Ҷ�任ѡ��------------------------------------------------------------------
function Fourier_Callback(hObject, eventdata, handles)

% set(handles.edit1, 'visible','off'); %����
set(handles.edit1, 'visible','on'); %��ʾ
% set(handles.edit2, 'visible','off'); %����
set(handles.edit2, 'visible','on'); %��ʾ
% set(handles.edit3, 'visible','off'); %����
set(handles.edit3, 'visible','on'); %��ʾ

%����Ҷ�任
figure=imread('Lena512.bmp');  %��ȡԭͼ  
%ԭͼ
subplot(1,3,1);
imshow(figure);
title('Lenaԭͼ');

%����Ҷ�任
fourier = fft2(figure);  %��ά����Ҷ�任        
shiftf=fftshift(fourier);  %����Ƶ���Ƶ�Ƶ���м�    
R=real(shiftf);                % ȡ����Ҷ�任��ʵ��
I=imag(shiftf);                % ȡ����Ҷ�任���鲿
spectrum = sqrt(R.^2+I.^2);             % ����Ƶ�׷�ֵ
spectrum_norm =(spectrum-min(min(spectrum)))./(max(max(spectrum))-min(min(spectrum)))*255;%��һ��
subplot(1,3,2);
imshow(spectrum_norm);        % ��ʾԭͼ����Ҷ�任Ƶ��
title('����Ҷ�任Ƶ��')

%����Ҷ���任
[height,width]=size(figure);
spectrum2=sort(reshape(spectrum,[1,width*height]));%���ع�Ϊ1�У�Ȼ����������ȡ��ֵ
value_threshold = 0.90;
threshold=spectrum2(round(width*height*value_threshold)); %ȡ����Ϊ0.90���Ǹ���
for p=1:height
     for j=1:width
         if spectrum(p,j)<threshold  %С����������Ϊ0
             R(p,j)=0;
             I(p,j)=0;
         end
     end
end
refigure=ifft2(ifftshift(R+1i*I)) ;  %R+jI����Ƶ�ƣ��ٸ���Ҷ���任
subplot(1,3,3);
imshow(uint8(refigure));
title('����Ҷ���任ͼ��');
PSNR = PSNR_cal(figure,refigure,8); %����PSNR
set(handles.edit2,'string',PSNR);
set(handles.edit3,'string',value_threshold);


% --��ɢ���ұ任ѡ��------------------------------------------------------------------
function DCT_Callback(hObject, eventdata, handles)

% set(handles.edit1, 'visible','off'); %����
set(handles.edit1, 'visible','on'); %��ʾ
% set(handles.edit2, 'visible','off'); %����
set(handles.edit2, 'visible','on'); %��ʾ
% set(handles.edit3, 'visible','off'); %����
set(handles.edit3, 'visible','on'); %��ʾ

%��ɢ���ұ任
figure = imread('Lena512.bmp');  %��ȡԭͼ   
%figure=rgb2gray(figure);  %ת��Ϊ�Ҷ�ͼ
%ԭͼ
subplot(1,3,1);
imshow(figure);
title('Lenaԭͼ');
%��ɢ���ұ任
DCT=dct2(figure);  %������ɢ���ұ任
subplot(1,3,2);
imshow(uint8(abs(DCT)));
title('��ɢ���ұ任')

%��ɢ������任
[height,width]=size(DCT);
DCT_sort=sort(reshape(abs(DCT),1,width*height));%���ع�Ϊ1�У�Ȼ����������
value_threshold = 0.90;
threhold=DCT_sort(round(width*height*value_threshold)); %����ֵ0.90
DCT(abs(DCT)<threhold)=0;  %��������С������ֵ������Ϊ0
refigure=idct2(DCT);  %DCT��任
subplot(1,3,3);
imshow(uint8(refigure));
title('��ɢ������任ͼ��');
PSNR = PSNR_cal(figure,refigure,8); %����PSNR
set(handles.edit2,'string',PSNR);
set(handles.edit3,'string',value_threshold);


% --������任ѡ��------------------------------------------------------------------
function DHT_Callback(hObject, eventdata, handles)

% set(handles.edit1, 'visible','off'); %����
set(handles.edit1, 'visible','on'); %��ʾ
% set(handles.edit2, 'visible','off'); %����
set(handles.edit2, 'visible','on'); %��ʾ
% set(handles.edit3, 'visible','off'); %����
set(handles.edit3, 'visible','on'); %��ʾ

%������任
figure=imread('Lena512.bmp');  
%ԭͼ
subplot(1,3,1);
imshow(figure);
title('Lenaԭͼ');
%������任
H=hadamard(512);
figure=double(figure);
DHT=(H*figure*H)./(512^2);
subplot(1,3,2);
imshow(DHT);
title('������任')
%��������任
[height,width]=size(figure);
DHT_sort=sort(reshape(abs(DHT),1,width*height));  %����ȡ��ֵ
value_threshold = 0.90;
threshold=abs(DHT_sort(round(width*height*value_threshold)));  %����
DHT(abs(DHT)<threshold)=0;
iH=H;%^-1;
refigure=(iH*DHT*iH);%*512;
subplot(1,3,3);
imshow(uint8(refigure));
title('��������任ͼ��');
PSNR = PSNR_cal(figure,refigure,8); %����PSNR
set(handles.edit2,'string',PSNR);
set(handles.edit3,'string',value_threshold);

function [ PSNR ] = PSNR_cal(figure1,figure2,bit)
img = double(figure2);
imgn = double(figure1);
[height,width]=size(figure1);
MAX = 2^bit-1;
PMSE = sum(sum((img-imgn).^2))/(height*width)/MAX^2;
PSNR = -10*log10(PMSE);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function phcompare_Callback(hObject, eventdata, handles)
% hObject    handle to phcompare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit1, 'visible','off'); %����
% set(handles.edit1, 'visible','on'); %��ʾ
set(handles.edit2, 'visible','off'); %����
% set(handles.edit2, 'visible','on'); %��ʾ
set(handles.edit3, 'visible','off'); %����
% set(handles.edit3, 'visible','on'); %��ʾ


%����Ҷ�任
figure=imread('Lena512.bmp');  %��ȡԭͼ  

%����Ҷ�任
fourier = fft2(figure);  %��ά����Ҷ�任        
shiftf=fftshift(fourier);  %����Ƶ���Ƶ�Ƶ���м�    
R=real(shiftf);                % ȡ����Ҷ�任��ʵ��
I=imag(shiftf);                % ȡ����Ҷ�任���鲿
spectrum = sqrt(R.^2+I.^2);             % ����Ƶ�׷�ֵ
spectrum_norm =(spectrum-min(min(spectrum)))./(max(max(spectrum))-min(min(spectrum)))*255;%��һ��

menxian = 0.9;
%����Ҷ���任
[height,width]=size(figure);
spectrum2=sort(reshape(spectrum,[1,width*height]));%���ع�Ϊ1�У�Ȼ����������ȡ��ֵ
threshold=spectrum2(round(width*height*menxian)); %ȡ����Ϊ0.90���Ǹ���
for p=1:height
     for j=1:width
         if spectrum(p,j)<threshold  %С����������Ϊ0
             R(p,j)=0;
             I(p,j)=0;
         end
     end
end
refigure=ifft2(ifftshift(R+1i*I)) ;  %R+jI����Ƶ�ƣ��ٸ���Ҷ���任

PSNR1 = PSNR_cal(figure,refigure,8); %����PSNR
subplot(1,3,1);
imshow(uint8(refigure));
title('����Ҷ���任');
xlabel(sprintf('PSNR=%.2f dB,����=%0.2f',PSNR1,menxian));


%��ɢ���ұ任
figure = imread('Lena512.bmp');  %��ȡԭͼ   

DCT=dct2(figure);  %������ɢ���ұ任

menxian = 0.927;
%��ɢ������任
[height,width]=size(DCT);
DCT_sort=sort(reshape(abs(DCT),1,width*height));%���ع�Ϊ1�У�Ȼ����������
threhold=DCT_sort(round(width*height*menxian)); %����ֵ0.90
DCT(abs(DCT)<threhold)=0;  %��������С������ֵ������Ϊ0
refigure=idct2(DCT);  %DCT��任

PSNR2 = PSNR_cal(figure,refigure,8); %����PSNR
subplot(1,3,2);
imshow(uint8(refigure));
title('��ɢ������任');
xlabel(sprintf('PSNR=%.2f dB,����=%0.2f',PSNR2,menxian));


%������任
figure=imread('Lena512.bmp');  

H=hadamard(512);
figure=double(figure);
DHT=(H*figure*H)./(512^2);

menxian = 0.8409;
[height,width]=size(figure);
DHT_sort=sort(reshape(abs(DHT),1,width*height));  %����ȡ��ֵ
threshold=abs(DHT_sort(round(width*height*menxian)));  %����
DHT(abs(DHT)<threshold)=0;
iH=H;%^-1;
refigure=(iH*DHT*iH);%*512;

PSNR3 = PSNR_cal(figure,refigure,8); %����PSNR

subplot(1,3,3);
imshow(uint8(refigure));
title('��������任');
xlabel(sprintf('PSNR=%.2f dB,����=%0.2f',PSNR3,menxian));


% --------------------------------------------------------------------
function compareline_Callback(hObject, eventdata, handles)
% hObject    handle to compareline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit1, 'visible','off'); %����
% set(handles.edit1, 'visible','on'); %��ʾ
set(handles.edit2, 'visible','off'); %����
% set(handles.edit2, 'visible','on'); %��ʾ
set(handles.edit3, 'visible','off'); %����
% set(handles.edit3, 'visible','on'); %��ʾ

x = zeros(1,46);
y = zeros(1,46);
z = zeros(1,46);
j=1;
for i=0.5:0.01:0.95
    
   [x(1,j),y(1,j),z(1,j)]=compare3(i); 
   j=j+1;
end

% figure(1);
subplot(1,1,1);
i=0.5:0.01:0.95;
plot(i,x);
hold on;
plot(i,y);
hold on;
plot(i,z);
xlabel('��Ԫ��ռ��');
ylabel('PSNR/dB');
legend('����Ҷ�任','��ɢ���ұ任','������任');


function [PSNR1,PSNR2,PSNR3]=compare3(menxian)
%����Ҷ�任
figure=imread('Lena512.bmp');  %��ȡԭͼ  
%ԭͼ
%subplot(1,3,1);
% imshow(figure);
% title('Lenaԭͼ');

%����Ҷ�任
fourier = fft2(figure);  %��ά����Ҷ�任        
shiftf=fftshift(fourier);  %����Ƶ���Ƶ�Ƶ���м�    
R=real(shiftf);                % ȡ����Ҷ�任��ʵ��
I=imag(shiftf);                % ȡ����Ҷ�任���鲿
spectrum = sqrt(R.^2+I.^2);             % ����Ƶ�׷�ֵ
spectrum_norm =(spectrum-min(min(spectrum)))./(max(max(spectrum))-min(min(spectrum)))*255;%��һ��
% subplot(1,3,2);
% imshow(spectrum_norm);        % ��ʾԭͼ����Ҷ�任Ƶ��
% title('����Ҷ�任Ƶ��')

%menxian = 0.9;
%����Ҷ���任
[height,width]=size(figure);
spectrum2=sort(reshape(abs(spectrum),[1,width*height]));%���ع�Ϊ1�У�Ȼ����������ȡ��ֵ
threshold1=spectrum2(round(width*height*menxian)); %ȡ����Ϊ0.90���Ǹ���
for p=1:height
     for j=1:width
         if spectrum(p,j)<threshold1  %С����������Ϊ0
             R(p,j)=0;
             I(p,j)=0;
         end
     end
end
refigure=ifft2(ifftshift(R+1i*I)) ;  %R+jI����Ƶ�ƣ��ٸ���Ҷ���任


PSNR1 = PSNR_cal(figure,uint8(refigure),8); %����PSNR
%PSNR
% subplot(1,3,1);
% imshow(uint8(refigure));
% title('����Ҷ���任');
% xlabel(sprintf('PSNR=%.2f dB,����=%0.2f',PSNR1,menxian));

%��ɢ���ұ任
figure = imread('Lena512.bmp');  %��ȡԭͼ   
%figure=rgb2gray(figure);  %ת��Ϊ�Ҷ�ͼ
%ԭͼ
% subplot(1,3,1);
% imshow(figure);
% title('Lenaԭͼ');
%��ɢ���ұ任
DCT=dct2(figure);  %������ɢ���ұ任
% subplot(1,3,2);
% imshow(uint8(abs(DCT)));
% title('��ɢ���ұ任')

%menxian = 0.9633;
%��ɢ������任
[height,width]=size(DCT);
DCT_sort=sort(reshape(abs(DCT),1,width*height));%���ع�Ϊ1�У�Ȼ����������
threhold2=DCT_sort(round(width*height*menxian)); %����ֵ0.90
DCT(abs(DCT)<threhold2)=0;  %��������С������ֵ������Ϊ0
refigure=idct2(DCT);  %DCT��任

PSNR2 = PSNR_cal(figure,uint8(refigure),8); %����PSNR
% PSNR
% subplot(1,3,2);
% imshow(uint8(refigure));
% title('��ɢ������任');
% xlabel(sprintf('PSNR=%.2f dB,����=%0.2f',PSNR2,menxian));



%������任
figure=imread('Lena512.bmp');  
%ԭͼ
% subplot(1,3,1);
% imshow(figure);
% title('Lenaԭͼ');

H=hadamard(512);
figure=double(figure);
DHT=(H*figure*H)./(512^2);
% subplot(1,3,2);
% imshow(uint8(DHT));
% title('������任')

%menxian = 0.92;
[height,width]=size(figure);
DHT_sort=sort(reshape(abs(DHT),1,width*height));  %����ȡ��ֵ
threshold3=abs(DHT_sort(round(width*height*menxian)));  %����
DHT(abs(DHT)<threshold3)=0;
iH=H;%^-1;
refigure=(iH*DHT*iH);%*512;

PSNR3 = PSNR_cal(figure,uint8(refigure),8); %����PSNR
% PSNR

% subplot(1,3,3);
% imshow(uint8(refigure));
% title('��������任');
% xlabel(sprintf('PSNR=%.2f dB,����=%0.2f',PSNR3,menxian));
