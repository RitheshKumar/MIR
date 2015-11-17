% normalization of feature

function NormFeature=normalizeZeroToOne(feature)
[rwfeature,clfeature]=size(feature);
NormFeature = zeros (rwfeature,clfeature);
for i=1:rwfeature
    NormFeature(i,:)=(feature(i,:)-min(feature(i,:)))./(max(feature(i,:))-min(feature(i,:)));
end
end