function varargout = GUI_2(varargin)
% GUI_2 MATLAB code for GUI_2.fig
%      GUI_2, by itself, creates a new GUI_2 or raises the existing
%      singleton*.
%
%      H = GUI_2 returns the handle to a new GUI_2 or the handle to
%      the existing singleton*.
%
%      GUI_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_2.M with the given input arguments.
%
%      GUI_2('Property','Value',...) creates a new GUI_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_2

% Last Modified by GUIDE v2.5 12-May-2021 16:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_2_OutputFcn, ...
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


% --- Executes just before GUI_2 is made visible.
function GUI_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_2 (see VARARGIN)

% Choose default command line output for GUI_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
figure=imread('Lena512.bmp'); 
subplot(1,3,2);
imshow(figure);
title('Lena原图 512x512');


% --------------------------------------------------------------------
function recovery_Callback(hObject, eventdata, handles)
% hObject    handle to recovery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function inverse_Callback(hObject, eventdata, handles)
% hObject    handle to inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y,H1,Q0_noise,lena]=degradation;

r=[34,33,30];  %最佳半径33-34

peaksnr=0;
for i=0:0.1:1
    [peaksnr1]=inverse_peaksnr(33+i,x,y,H1,Q0_noise,lena);
    if peaksnr1 > peaksnr
        peaksnr =peaksnr1;
        r(3)=33+i;
    end
end

for i=1:3
    inverse_filter(r(i),x,y,i+3,H1,Q0_noise,lena);
end



% --------------------------------------------------------------------
function wiener_Callback(hObject, eventdata, handles)
% hObject    handle to wiener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[~,~,H1,Q0_noise,lena]=degradation;

%维纳滤波
HM = abs(H1.*H1);
k = [0 0.001 0.003 ];  %最佳k值在0.001-0.003

peaksnr = 0;

for i=0:0.0001:0.002
   w = HM./(H1.*(HM+0.001+i));
   [peaksnr1]=wiener_peaksnr(w,Q0_noise,lena);
   if peaksnr1>peaksnr
      peaksnr =peaksnr1;
      k(3)=0.001+i;
   end
end

w = cell(1,3);
for i=1:3
   w{i} = HM./(H1.*(HM+k(i))); 
end

for i=1:3
    wiener_filter(i,k(i),w{i},Q0_noise,lena);
end


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% ---------------------函数定义----------------------------------------
function [ ] = inverse_filter( r , x, y, card, H1, Q0, lena )

Q0_inv = zeros(x,y);

for a=1:x
    for b=1:y
        if sqrt((a-x/2).^2+(b-y/2).^2)<r%((x/2)*r)^2
            Q0_inv(a,b) = Q0(a,b)./H1(a,b);
        end
    end
end




% x_r=round(x*r);  %复原区域长度
% y_r=round(y*r);  %复原区域宽度
% 
% H_r=ones(x,y).*1;  %100000;
% H_r(1:x_r,1:y_r)=H1(1:x_r,1:y_r);  %创建复原矩阵
% 
% Q0_inv=Q0./H_r;  %频域复原
q0_inv=real(ifft2(ifftshift(Q0_inv)));  %傅里叶反变换后取实部
q0_inv=uint8(255.*mat2gray(q0_inv));  %先归一化到0-1之间，再映射到0-255

peaksnr=PSNR_cal(lena,q0_inv,8);  %计算峰值信噪比PSNR

% q0_inv=uint8(real(ifft2(Q0_inv)));
% peaksnr=PSNR_cal(lena,q0_inv,8); % PSNR

%  绘制复原图形
subplot(2,3,card);
imshow(q0_inv);
% imshow(uint8(255.*mat2gray(q0_inv)));
title(sprintf('r_0=%.1f , PSNR=%.4f dB',r,peaksnr));

function [peaksnr] = inverse_peaksnr( r , x, y, H1, Q0, lena )

Q0_inv = zeros(x,y);

for a=1:x
    for b=1:y
        if sqrt((a-x/2).^2+(b-y/2).^2)<r%((x/2)*r)^2
            Q0_inv(a,b) = Q0(a,b)./H1(a,b);
        end
    end
end

q0_inv=real(ifft2(ifftshift(Q0_inv)));  %傅里叶反变换后取实部
q0_inv=uint8(255.*mat2gray(q0_inv));  %先归一化到0-1之间，再映射到0-255

peaksnr=PSNR_cal(lena,q0_inv,8);  %计算峰值信噪比PSNR

function [ ] = wiener_filter( card, ki, W_k, Q0, lena )

Q_W=Q0.*W_k;
q_w=real(ifft2(ifftshift(Q_W)));
q_w=uint8(255.*mat2gray(q_w));
% q_k=uint8(q_k);

peaksnr=PSNR_cal(lena,q_w,8);          % PSNR

subplot(2,3,card+3);
imshow(q_w);
title(sprintf('K=%.4f , PSNR=%.4f dB',ki,peaksnr));

function [peaksnr] = wiener_peaksnr( W_k, Q0, lena )

Q_W=Q0.*W_k;
q_w=real(ifft2(ifftshift(Q_W)));
q_w=uint8(255.*mat2gray(q_w));
% q_k=uint8(q_k);

peaksnr=PSNR_cal(lena,q_w,8);          % PSNR

function [ PSNR ] = PSNR_cal(figure1,figure2,bit)
img = double(figure2);
imgn = double(figure1);
[height,width]=size(figure1);
MAX = 2^bit-1;
PMSE = sum(sum((img-imgn).^2))/(height*width)/MAX^2;
PSNR = -10*log10(PMSE);


function [x,y,H1,Q0_noise,lena] = degradation()
%参数定义
T=1;
a=0.02;
b=0.02;

lena=imread('lena512.bmp');  %读原图

subplot(2,3,1);
imshow(lena);
title('Lena原图');

[x,y]=size(lena);  %取原图长度和宽度

%  创建降质模型传递函数矩阵H1
u=(-x/2:x/2-1);
v=(-y/2:y/2-1)';
A = repmat(a.*u,x,1)+repmat(b.*v,1,y);
H1=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);
H1(A==0)=T;

fftlena=fftshift(fft2(lena));  %对原图进行傅里叶变换并且进行频移

Q0=fftlena.*H1;  %时域相乘等于频域卷积

q0=real(ifft2(ifftshift(Q0)));  %傅里叶反变换后取实部
q0=uint8(255.*mat2gray(q0));  %先通过mat2gray归一化0~1之间，再映射到0-255

peaksnr=PSNR_cal(lena,q0,8);  %计算峰值信噪比PSNR

%  绘制降质图像
subplot(2,3,2);
imshow(q0);
title(sprintf('降质图像, PSNR=%.4f dB',peaksnr));

noise_mean = 0;
noise_var = 1e-3;
noise = imnoise(zeros(x,y),'gaussian',noise_mean,noise_var);
fftnoise = fftshift(fft2(noise));
Q0_noise = Q0 + fftnoise;

q0_noise=real(ifft2(ifftshift(Q0_noise)));  %傅里叶反变换后取实部
q0_noise=uint8(255.*mat2gray(q0_noise));  %先通过mat2gray归一化0~1之间，再映射到0-255

subplot(2,3,3);
imshow(q0_noise);
peaksnr=PSNR_cal(lena,q0_noise,8);  %计算峰值信噪比PSNR
title(sprintf('降质图像&噪声, PSNR=%.4f dB',peaksnr));
