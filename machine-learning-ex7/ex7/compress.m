orig = 33;     % Size of original PNG in KB
fullim = 49;   % Size of 128 x 128 BMP  in KB

% Col 1 = number of colors
% Col 2 = size of resulting PNG in KB
d = [8, 6.6;
     16, 11;
     32, 17;
     64, 23;
     128, 27;
     256, 31;
     512, 32;
     1024, 32;
     2048, 33];

dr = [d(:,1), (orig .- d(:,2))./orig];

figure(1)
clf();
%subplot(2,1,1);
%semilogx(dr(:,1), dr(:,2), 'o-');
%hold on;
%semilogx(512, 0, 'r+');
%xlabel('Num Colors');
%ylabel('PNG Compression over Original');
%grid on;

load('fractions20-3.mat');
fractions_20_3 = fractions;
load('fractions10-3.mat');
fractions_10_3 = fractions;
load('fractions5-3.mat');
fractions_5_3 = fractions;

load('fractions5-3-b.mat');
fractions_5_3_b = fractions;
load('fractions5-3-bs.mat');
fractions_5_3_bs = fractions;
load('fractions20-3-b.mat');
fractions_20_3_b = fractions;

subplot(2,1,1);
hold on;
semilogxerr(Ks, mean(fractions_5_3, 2), range(fractions_5_3,2));
semilogxerr(Ks, mean(fractions_5_3_b, 2), range(fractions_5_3_b,2), '--');
semilogxerr(Ks, mean(fractions_5_3_bs, 2), range(fractions_5_3_bs,2), '--');
semilogx(512, 0, 'ro');
ylim([0 0.6]);
xlabel('Num Color Clusters');
ylabel('mean Fraction different Pixels');
grid on;
legend('k-means iter 5, 3 runs',
       'k-means iter 5, 3 runs, builtin', 'k-means iter 5, 3 runs, builtin singleton');

subplot(2,1,2);
hold on;
semilogxerr(Ks, mean(fractions_10_3, 2), range(fractions_10_3,2));
semilogxerr(Ks, mean(fractions_20_3, 2), range(fractions_20_3,2));
semilogxerr(Ks, mean(fractions_20_3_b, 2), range(fractions_20_3_b,2), '--');
semilogx(512, 0, 'ro');
ylim([0 0.6]);
xlabel('Num Color Clusters');
ylabel('mean Fraction different Pixels');
grid on;
legend('k-means iter 10, 3 runs','k-means iter 20, 3 runs',
       'k-means iter 20, 3 runs, builtin')
