function plot_signal(sub_total, sub_idx, xn, xorigin, name)
    subplot(sub_total, 1, sub_idx);
    n = (1:length(xn)) - xorigin;
    
    plot([min(n)-1, max(n)+1], [0, 0], 'k');
    plot([0, 0], [min(xn)-1, max(xn)+1], 'k');
    for i = 1:length(xn)
        plot([n(i), n(i)], [0, xn(i)], 'b');
    end
    plot(n, xn, 'ob');
    title(name);
    xgrid();
endfunction

function [yn, yorigin] = delay(xn, xorigin, k)
    yn = xn;
    yorigin = xorigin - k;
endfunction

function [yn, yorigin] = advance(xn, xorigin, k)
    yn = xn;
    yorigin = xorigin + k;
endfunction

function [yn, yorigin] = fold(xn, xorigin)
    yn = xn($:-1:1);
    yorigin = length(xn) - xorigin + 1; 
endfunction

function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    //find size of output
    n_min = min(1 - x1origin, 1 - x2origin);
    n_max = max(length(x1n) - x1origin, length(x2n) - x2origin);
    yn = zeros(1, n_max - n_min + 1);
    yorigin = max(x1origin, x2origin);

    // walk left from origin; x1n(i) = 0 or x2n(j) = 0 if out of range(<0 or >length)
    i = x1origin; j = x2origin; k = yorigin;
    while i > 0 || j > 0
        if i > 0 && j > 0 then
            yn(k) = x1n(i) + x2n(j);
        elseif i > 0 then
            yn(k) = x1n(i) + 0;
        elseif j > 0 then
            yn(k) = 0 + x2n(j);
        end
        i = i - 1; j = j - 1; k = k - 1;
    end

    // walk right from origin
    i = x1origin + 1; j = x2origin + 1; k = yorigin + 1;
    while i <= length(x1n) || j <= length(x2n)
        if i <= length(x1n) && j <= length(x2n) then
            yn(k) = x1n(i) + x2n(j);
        elseif i <= length(x1n) then
            yn(k) = x1n(i) + 0;
        elseif j <= length(x2n) then
            yn(k) = 0 + x2n(j);
        end
        i = i + 1; j = j + 1; k = k + 1;
    end
endfunction

function [yn, yorigin] = multi(x1n, x1origin, x2n, x2origin)
    //find size of output
    n_min = min(1 - x1origin, 1 - x2origin);
    n_max = max(length(x1n) - x1origin, length(x2n) - x2origin);
    yn = zeros(1, n_max - n_min + 1);
    yorigin = max(x1origin, x2origin);

    // walk left from origin; x1n(i) = 0 or x2n(j) = 0 if out of range(<0 or >length)
    i = x1origin; j = x2origin; k = yorigin;
    while i > 0 || j > 0
        if i > 0 && j > 0 then
            yn(k) = x1n(i) * x2n(j);
        elseif i > 0 then
            yn(k) = x1n(i) * 0;
        elseif j > 0 then
            yn(k) = 0 * x2n(j);
        end
        i = i - 1; j = j - 1; k = k - 1;
    end

    // walk right from origin
    i = x1origin + 1; j = x2origin + 1; k = yorigin + 1;
    while i <= length(x1n) || j <= length(x2n)
        if i <= length(x1n) && j <= length(x2n) then
            yn(k) = x1n(i) * x2n(j);
        elseif i <= length(x1n) then
            yn(k) = x1n(i) * 0;
        elseif j <= length(x2n) then
            yn(k) = 0 * x2n(j);
        end
        i = i + 1; j = j + 1; k = k + 1;
    end
endfunction

function [yn, yorigin] = convolution (xn, xorigin, hn, horigin)
    //find size of yn
    n_min = (1 - xorigin) + (1 - horigin);
    n_max = (length(xn) - xorigin) + (length(hn) - horigin);
    yn = zeros(1, n_max - n_min + 1);
    yorigin = 1 - n_min;
    
    //fold h(k) -> h(–k)
    [hf, hf_origin] = fold(hn, horigin);
    
    for n = 1:length(yn)
        n_index = n - yorigin;  //signal index of yn
        // shift h(-k) -> h(n-k)
        if n_index >= 0 then
            [hs, hs_origin] = delay(hf, hf_origin, n_index);
        else
            [hs, hs_origin] = advance(hf, hf_origin, -n_index);
        end

        // sum x(k)*h(n-k)
        for k = 1:length(xn)
            j = (k - xorigin) + hs_origin;  //find corresponding index of hs to xn
            if j >= 1 && j <= length(hs) then
                yn(n) = yn(n) + xn(k) * hs(j);
            end
        end
    end
end

//The discrete-time signal x(n)
xn = [9, 10, -2, 7, 3, -6, 5, 27];
xorigin = 3;
k = 1;
[yn, yorigin] = delay(xn, xorigin, k);
disp(yn);
disp(yorigin);
figure();
plot_signal(2, 1, xn, xorigin, 'x(n)');
plot_signal(2, 2, yn, yorigin, 'y(n) = x(n-k)');

[yn, yorigin] = advance(xn, xorigin, k);
disp(yn);
disp(yorigin);
figure();
plot_signal(2, 1, xn, xorigin, 'x(n)');
plot_signal(2, 2, yn, yorigin, 'y(n) = x(n+k)');

[yn, yorigin] = fold(xn, xorigin);
disp(yn);
disp(yorigin);
figure();
plot_signal(2, 1, xn, xorigin, 'x(n)');
plot_signal(2, 2, yn, yorigin, 'y(n) = x(-n)');


x1n = [9, 10, -2, 7, 3, -6, 5, 27]; x1origin = 1;
x2n = [1, 1, 2, 3]; x2origin = 2;
[yn, yorigin] = add(x1n, x1origin, x2n, x2origin);
disp(yn);
disp(yorigin);
figure();
plot_signal(3, 1, x1n, x1origin, 'x1(n)');
plot_signal(3, 2, x2n, x2origin, 'x2(n)');
plot_signal(3, 3, yn,  yorigin,  'y(n) = x1+x2');


[yn, yorigin] = multi(x1n, x1origin, x2n, x2origin);
disp(yn);
disp(yorigin);
figure();
plot_signal(3, 1, x1n, x1origin, 'x1(n)');
plot_signal(3, 2, x2n, x2origin, 'x2(n)');
plot_signal(3, 3, yn,  yorigin,  'y(n) = x1*x2');


xn = [9, 10, -2, 7, 3, -6, 5, 27]; xorigin = 1;
hn = [1, 1, 2, 3]; horigin = 2;
[yn, yorigin] = convolution (xn, xorigin, hn, horigin);
disp(yn);
disp(yorigin);
figure();
plot_signal(3, 1, xn, xorigin, 'x(n)');
plot_signal(3, 2, hn, horigin, 'h(n)');
plot_signal(3, 3, yn, yorigin,  'convolution');
